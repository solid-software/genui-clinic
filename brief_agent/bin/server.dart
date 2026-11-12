import 'package:brief_agent/brief/brief_agent.dart';
import 'package:brief_agent/brief/brief_function.dart';
import 'package:brief_agent/usage_limit/usage_limit_enforcer.dart';
import 'package:brief_agent/gemini/gemini_client.dart';
import 'package:brief_agent/usage_limit/usage_repository.dart';
import 'package:firebase_functions/firebase_functions.dart';

/// Both functions' options: only the app, attested by App Check, may spend
/// Gemini quota, with up to three model attempts and a repair turn.
const _options = CallableOptions(
  region: Region(.europeWest1),
  enforceAppCheck: EnforceAppCheck(true),
  memory: Memory(.mb512),
  timeoutSeconds: TimeoutSeconds(300),
  maxInstances: Instances(10),
);

/// Serves `briefagent`, the callable the app asks for each brief, and
/// `briefagent-staging`, the same callable for the staging site, deployed
/// and updated independently so staging testing never touches the live
/// function.
///
/// A function's URL is
/// `https://<name>-<project number>.europe-west1.run.app`.
Future<void> main() => runFunctions((firebase) {
  final brief = BriefFunction(BriefAgent(GeminiClient.forThisProject()));
  final limit = UsageLimitEnforcer(
    UsageRepository(firebase.adminApp.firestore()),
  );

  Future<JsonResult> answer(CallableRequest request) async {
    final CallableRequest(:auth, :data) = request;

    if (auth?.uid case final id?) {
      await limit.gate(id);

      return brief.answer(data);
    } else {
      throw HttpResponseException.unauthorized();
    }
  }

  firebase.https.onCall(
    name: 'briefagent',
    options: _options,
    (request, _) => answer(request),
  );
  firebase.https.onCall(
    name: 'briefagent-staging',
    options: _options,
    (request, _) => answer(request),
  );
});
