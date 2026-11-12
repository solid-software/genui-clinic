import 'package:brief_agent/brief/brief_agent.dart';
import 'package:brief_agent/brief/brief_function.dart';
import 'package:brief_agent/gemini/gemini_client.dart';
import 'package:brief_agent/usage_limit/usage_limit_enforcer.dart';
import 'package:brief_agent/usage_limit/usage_repository.dart';
import 'package:firebase_functions/firebase_functions.dart';

class BriefRunner(final Firebase _firebase) {
  final _brief = BriefFunction(BriefAgent(GeminiClient.forThisProject()));
  late final _limit = UsageLimitEnforcer(
    UsageRepository(_firebase.adminApp.firestore()),
  );

  Future<JsonResult> answer({
    required CallableRequest request,
    bool gate = true,
  }) async {
    final CallableRequest(:auth, :data) = request;

    final id = auth?.uid;
    if (id == null) throw HttpResponseException.unauthorized();

    if (gate) await _limit.gate(id);

    return _brief.answer(data);
  }
}
