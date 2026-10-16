import 'package:brief_agent/brief/brief_agent.dart';
import 'package:brief_agent/brief/brief_function.dart';
import 'package:brief_agent/usage_limit/usage_limit_enforcer.dart';
import 'package:brief_agent/gemini/gemini_client.dart';
import 'package:brief_agent/usage_limit/usage_repository.dart';
import 'package:firebase_functions/firebase_functions.dart';

/// Serves `briefagent`, the callable the app asks for each brief.
///
/// Its URL is `https://briefagent-<project number>.europe-west1.run.app`.
Future<void> main() => runFunctions((firebase) {
  final brief = BriefFunction(BriefAgent(GeminiClient.forThisProject()));

  final limit = UsageLimitEnforcer(
    UsageRepository(firebase.adminApp.firestore()),
  );

  firebase.https.onCall(
    name: 'briefagent',
    options: const CallableOptions(
      region: Region(.europeWest1),
      // Only the app, attested by App Check, may spend Gemini quota.
      enforceAppCheck: EnforceAppCheck(true),
      memory: Memory(.mb512),
      // Up to three model attempts and a repair turn.
      timeoutSeconds: TimeoutSeconds(300),
      maxInstances: Instances(10),
    ),
    (request, _) async {
      final CallableRequest(:auth, :data) = request;

      if (auth?.uid case final id?) {
        await limit.gate(id);

        return brief.answer(data);
      } else {
        throw HttpResponseException.unauthorized();
      }
    },
  );
});
