import 'dart:async';
import 'dart:convert';

import 'package:a2ui_core/a2ui_core.dart' as core;
import 'package:clinical_brief/brief_composer/models/brief_exchange.dart';
import 'package:clinical_brief/brief_composer/models/brief_turn.dart';
import 'package:clinical_brief/brief_composer/services/brief_agent_client.dart';
import 'package:clinical_brief/common/logging/app_logger.dart';
import 'package:genui/genui.dart';

/// Carries one consultation between GenUI and the brief agent: turns go out,
/// A2UI JSON comes back for the surface controller.
///
/// The agent keeps nothing between turns, so the transport holds the
/// consultation, each turn with the brief that answered it, and sends it
/// along with the next turn.
class BriefTransport(
  final BriefAgentClient _agent,
  final Map<String, Object?> _capabilities,
) implements Transport {
  /// The key of an A2UI error message, as GenUI reports one.
  static const String _error = 'error';
  final _messages = StreamController<core.A2uiMessage>.broadcast();
  final _text = StreamController<String>.broadcast();
  final _log = AppLogger.of('BriefTransport');
  var _history = const <BriefExchange>[];
  var _previousTurn = Future<void>.value();

  /// Creates brief transport
  this;

  @override
  Stream<core.A2uiMessage> get incomingMessages => _messages.stream;

  /// Stays empty: the agent answers in A2UI messages only.
  @override
  Stream<String> get incomingText => _text.stream;

  /// Whether the agent has answered a turn of this consultation yet.
  bool get hasBrief => _history.isNotEmpty;

  /// Asks the agent to answer [turn] and hands the brief to the renderer.
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

  /// Sends an action on the brief, which GenUI reports by itself, to the
  /// agent as a turn of its own.
  ///
  /// An error GenUI finds in a brief is only logged: the agent has already
  /// checked it against the catalog, and asking again could loop.
  @override
  Future<void> sendRequest(ChatMessage message) async {
    for (final part in message.parts) {
      final interaction = part.asUiInteractionPart;
      if (interaction == null) continue;
      final event = _decode(interaction.interaction);
      if (event.containsKey(_error)) {
        _log.warning('GenUI found a problem in the brief: $event');
      } else {
        await send(BriefTurn.rendererEvent(event));
      }
    }
  }

  @override
  void dispose() {
    unawaited(_messages.close());
    unawaited(_text.close());
  }

  Future<void> _exchange(BriefTurn turn) async {
    if (_messages.isClosed) return;
    // An opening turn starts the consultation over.
    final history = turn.isOpening ? const <BriefExchange>[] : _history;
    final brief = await _agent.compose(
      capabilities: _capabilities,
      history: history,
      turn: turn,
    );
    if (_messages.isClosed) return;
    final messages = brief.map(core.A2uiMessage.fromJson).toList();
    _history = [
      ...history,
      BriefExchange(turn: turn, brief: brief),
    ];
    _log.fine('The agent sent ${messages.length} A2UI messages.');
    messages.forEach(_messages.add);
    // Let the messages reach the surface before the turn counts as done.
    await Future<void>.delayed(Duration.zero);
  }

  /// [interaction], the A2UI JSON GenUI encoded, as a map.
  static Map<String, Object?> _decode(String interaction) =>
      switch (jsonDecode(interaction)) {
        final Map<String, Object?> json => json,
        final Object? other => {'message': other},
      };
}
