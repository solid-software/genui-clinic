import 'package:a2ui_core/a2ui_core.dart';
import 'package:brief_agent/brief/brief_agent.dart';
import 'package:brief_agent/brief/models/brief_request.dart';
import 'package:firebase_functions/firebase_functions.dart';
import 'package:firebase_functions/logger.dart' as logger;

/// The callable function: a [BriefRequest] in, the brief's A2UI JSON out.
class BriefFunction {
  /// The agent's budget and a moment to spare, inside the function's 300 s.
  static const Duration _timeout = Duration(seconds: 255);

  final BriefAgent _agent;

  /// Creates the function around [_agent].
  const BriefFunction(this._agent);

  /// Answers one call with `{"messages": [...]}`, the brief's A2UI messages.
  ///
  /// Throws [HttpResponseException], which the app receives as a
  /// `FirebaseFunctionsException`.
  Future<JsonResult> answer(Object? data) async {
    final BriefRequest request;
    try {
      request = BriefRequest.fromJson(data);
    } on FormatException catch (error) {
      throw HttpResponseException.badRequest(message: error.message);
    }

    try {
      return JsonResult(<String, dynamic>{
        'messages': await _agent.compose(request).timeout(_timeout),
      });
    } on A2uiError catch (error) {
      // The app's capabilities declare nothing this agent can prompt for, or
      // its history holds a brief this agent could not have sent.
      throw HttpResponseException.badRequest(message: error.message);
    } on Exception catch (error, stackTrace) {
      logger.error('Could not compose the brief.', <String, Object?>{
        'error': '$error',
      }, stackTrace);
      throw HttpResponseException.internalServerError(
        message: 'The brief could not be composed.',
        innerError: error,
        innerStack: stackTrace,
      );
    }
  }
}
