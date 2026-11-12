import 'dart:async';

import 'package:clinical_brief/brief_composer/models/brief_exchange.dart';
import 'package:clinical_brief/brief_composer/models/brief_turn.dart';
import 'package:clinical_brief/brief_composer/services/brief_agent_client.dart';

/// Carries one consultation between the app and the brief agent: turns go
/// out, A2UI JSON comes back for [_onMessages].
///
/// The agent keeps nothing between turns, so the transport holds the
/// consultation, each turn with the brief that answered it, and sends it
/// along with the next turn.
class BriefTransport(
  final BriefAgentClient _agent,
  final Map<String, Object?> _capabilities,
  final void Function(List<Map<String, Object?>> messages) _onMessages,
) {
  var _history = const <BriefExchange>[];
  var _previousTurn = Future<void>.value();
  var _isDisposed = false;

  /// Creates brief transport
  this;

  /// Whether the agent has answered a turn of this consultation yet.
  bool get hasBrief => _history.isNotEmpty;

  /// Asks the agent to answer [turn] and hands the brief's A2UI messages to
  /// [_onMessages].
  ///
  /// Turns run one after another, so the agent reads them in order.
  Future<void> send(BriefTurn turn) async {
    final thisTurn = Completer<void>();
    final previousTurn = _previousTurn;
    _previousTurn = thisTurn.future;
    try {
      await previousTurn;
      await _exchange(turn);
    } finally {
      thisTurn.complete();
    }
  }

  /// Stops delivering any brief still in flight.
  void dispose() {
    _isDisposed = true;
  }

  Future<void> _exchange(BriefTurn turn) async {
    if (_isDisposed) return;
    // An opening turn starts the consultation over.
    final history = turn.isOpening ? const <BriefExchange>[] : _history;
    final brief = await _agent.compose(
      capabilities: _capabilities,
      history: history,
      turn: turn,
    );
    if (_isDisposed) return;
    _history = [
      ...history,
      BriefExchange(turn: turn, brief: brief),
    ];
    _onMessages(brief);
  }
}
