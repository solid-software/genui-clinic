import 'package:clinical_brief/brief_composer/brief_limit_exception.dart';
import 'package:clinical_brief/brief_composer/models/brief_exchange.dart';
import 'package:clinical_brief/brief_composer/models/brief_turn.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';

/// The brief agent, the `briefagent` Cloud Function in brief_agent/.
///
/// It asks Gemini for the brief in A2UI Express and compiles that with the
/// A2UI agent SDK on the server, so the app only ever receives A2UI JSON.
class BriefAgentClient._(final HttpsCallable _callable) {
  /// Replaces the agent's URL, e.g. with the Functions emulator's.
  static const _urlOverride = String.fromEnvironment('BRIEF_AGENT_URL');
  static const _functionName = 'briefagent';
  static const _region = 'europe-west1';

  /// The code of the agent's answer to a user over their limit.
  static const _limitReached = 'resource-exhausted';

  /// The function's own limit: model retries and a repair turn fit in it.
  static const _timeout = Duration(seconds: 300);

  /// The agent of [app]'s Firebase project.
  factory forApp(FirebaseApp app) => BriefAgentClient._(
    FirebaseFunctions.instanceFor(
      app: app,
      region: _region,
    ).httpsCallableFromUri(
      _urlOf(app),
      options: .new(timeout: _timeout),
    ),
  );

  /// Asks for the brief that answers [turn], after the consultation so far
  /// in [history], for a renderer with [capabilities].
  ///
  /// The agent keeps nothing between calls, so [history] goes with every
  /// turn. Returns the brief's A2UI messages. Throws [BriefLimitException]
  /// when the user reached a usage limit, `FirebaseFunctionsException` if
  /// the agent fails otherwise, and [FormatException] if it sends no
  /// messages.
  Future<List<Map<String, Object?>>> compose({
    required Map<String, Object?> capabilities,
    required List<BriefExchange> history,
    required BriefTurn turn,
  }) async {
    final HttpsCallableResult<Object?> result;
    try {
      result = await _callable.call<Object?>(
        {
          'capabilities': capabilities,
          'history': history.map((e) => e.toJson()).toList(),
          'turn': turn.toJson(),
        },
      );
    } on FirebaseFunctionsException catch (error) {
      if (error.code != _limitReached) rethrow;
      throw BriefLimitException.fromDetails(error.details);
    }

    return switch (_plain(result.data)) {
      {'messages': final List<Object?> messages} => [
        for (final message in messages)
          switch (message) {
            final Map<String, Object?> json => json,
            _ => throw FormatException('Not an A2UI message: $message'),
          },
      ],
      final Object? data => throw FormatException('No brief in $data'),
    };
  }

  /// Cloud Run gives the function a URL made of its name, the project
  /// number and the region; the Firebase sender ID is the project number.
  static Uri _urlOf(FirebaseApp app) => Uri.parse(
    _urlOverride.isNotEmpty
        ? _urlOverride
        : 'https://$_functionName-${app.options.messagingSenderId}'
              '.$_region.run.app',
  );

  /// [value] with every map keyed by strings, as `A2uiMessage.fromJson`
  /// expects: platform channels hand back `Map<Object?, Object?>`.
  static Object? _plain(Object? value) => switch (value) {
    final Map<Object?, Object?> map => map.map(
      (k, v) => MapEntry('$k', _plain(v)),
    ),
    final List<Object?> list => list.map(_plain).toList(),
    _ => value,
  };
}
