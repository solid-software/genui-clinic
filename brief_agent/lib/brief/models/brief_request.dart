import 'package:brief_agent/brief/models/brief_exchange.dart';
import 'package:brief_agent/brief/models/brief_turn.dart';
import 'package:brief_agent/common/utils/json_fields.dart';

/// One call from the app: what it can render, the consultation so far and
/// the turn to answer.
///
/// The agent keeps nothing between calls. The app holds the consultation in
/// A2UI JSON, so the model's Express never leaves the agent.
class const BriefRequest._({
  /// The app's `a2uiClientCapabilities`: the catalogs it can render.
  required final Map<String, Object?> capabilities,

  /// The earlier turns and their briefs, oldest first; empty for an opening.
  required final List<BriefExchange> history,

  /// The turn to answer.
  required final BriefTurn turn,

  /// The turn the consultation opened with: the first of [history], or
  /// [turn] itself.
  required final OpeningTurn opening,
}) {
  /// Reads the request the app sent.
  ///
  /// Throws [FormatException] if [json] is not a request, or if its first
  /// turn is not the only opening one.
  factory BriefRequest.fromJson(Object? json) {
    final request = JsonFields.asObject(json, 'request');
    final history = JsonFields.list(
      request,
      'history',
    ).map(BriefExchange.fromJson).toList();
    final turn = BriefTurn.fromJson(request['turn']);
    final first = history.isEmpty ? turn : history.first.turn;
    final reopens =
        history.isNotEmpty &&
        [
          for (final exchange in history.skip(1)) exchange.turn,
          turn,
        ].any((later) => later is OpeningTurn);
    if (first is! OpeningTurn || reopens) {
      throw const FormatException(
        'A consultation opens with its first turn, and only with it.',
      );
    }
    return BriefRequest._(
      capabilities: JsonFields.object(request, 'capabilities'),
      history: history,
      turn: turn,
      opening: first,
    );
  }
}
