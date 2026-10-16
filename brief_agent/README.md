# GenUI Clinic — the brief agent

`briefagent`, the Cloud Function the [app](../app/README.md) asks for each
brief.

## How it works

Each call carries:
- the app’s A2UI client capabilities,
- the conversation so far,
- and the new turn.

The agent then:

1. Negotiates the catalog with the SDK (`A2uiGenerator.createProcessor`),
   whose prompt snippet teaches Gemini the catalog in A2UI Express;
2. Decompiles earlier briefs back into Express (Parser.decompile),
   so the model sees its own past replies;
3. Requests a brief from Gemini on Vertex AI.
   If a model doesn’t reply within 20 seconds,
   the agent moves on to the next one;
4. Compiles the reply into A2UI messages using parseResponse,
   which extracts the Express block and validates the result.
   The agent then checks that the messages
   create exactly one new surface (BriefRules).
   If they don’t, it asks the model to resend the reply once.
5. Answers `{"messages": [...]}`, A2UI JSON, the only thing the app receives.

It stores nothing between calls, and Express never leaves it.
It authenticates to Gemini with its own service account, so there is no API key.
The agent accepts calls only from the app,
which proves its identity through App Check.

```
bin/server.dart      registers the callable
lib/brief/           BriefAgent, BriefFunction (the callable's handler), the
                     prompt and instructions, the rules a brief must meet,
                     the request, turn and exchange models
lib/catalog/         the app's catalog as the agent registers it, and the
                     transformers that prepare it for the Express prompt
lib/gemini/          Gemini on Vertex AI, with retries across models
lib/common/          typed reads of the JSON the app sends
lib/usage_limit      Rate-limits user requests to prevent abuse
```

The catalog document, `lib/catalog/clinical_catalog_document.g.dart`, is
generated from the app's catalog by `app/test/agent_catalog_test.dart`. The
agent does not start while it is the placeholder.

The agent needs two features that the latest pub.dev release of a2ui_agent lacks:
the catalog transformers and allowedMessages.
Until a release includes them,
a2ui_agent is pinned to an a2ui commit from 2026-10-05.

## Deploy

Deploy the agent manually whenever this folder or the catalog changes,
and always before releasing an app version that depends on these changes.

Once per machine, with Flutter (it brings Dart) and Node installed:

```bash
npm install -g firebase-tools@latest   # 15.15.0 or newer
firebase login
firebase experiments:enable dartfunctions
```

Write the catalog document if the app's catalog changed, and once now. From
`app/`:

```bash
UPDATE_AGENT_CATALOG=1 flutter test test/agent_catalog_test.dart
```

Then, from the repo root, where `firebase.json` is:

```bash
firebase deploy --only functions --project clinical-brief
```

The CLI compiles the agent on your machine and uploads it to Cloud Run;
answer yes if it asks to enable APIs. The Function URL it prints should be
`https://briefagent-<project number>.europe-west1.run.app`, which is where
the app sends its requests. Dart functions do not show in the Firebase
console yet: find `briefagent`, its logs included, under Cloud Run in the
Google Cloud console.

After the first deploy, once, let the agent's service account call Gemini
(the project number is on the Firebase project settings page):

```bash
gcloud projects add-iam-policy-binding clinical-brief \
  --member="serviceAccount:<project number>-compute@developer.gserviceaccount.com" \
  --role="roles/aiplatform.user"
```

In the console: Google Cloud → IAM → that account → **Vertex AI User**.

## Troubleshooting

| Symptom | Cause |
|---|---|
| The app gets `not-found` or a CORS error from `briefagent` | The agent is not deployed yet. |
| Every brief fails; the logs show `PERMISSION_DENIED` | Vertex AI is off, or the agent lacks its role (see Deploy). |
| The deploy fails; the logs say the catalog document is a placeholder | Generate it (see Deploy), then deploy again. |
| "This model is currently experiencing high demand" in the logs | Temporary overload at Google. The agent retries each request on up to three models; if all fail, the app shows **Try again**. |
| Nothing renders and no error in the app | The agent logs each reply's size and timing, and any reply it could not compile. |
