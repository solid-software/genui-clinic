import 'package:brief_agent/brief/models/brief_turn.dart';
import 'package:brief_agent/common/utils/json_fields.dart';

/// An earlier turn of the consultation and the brief that answered it, as
/// the app holds them: the brief in A2UI JSON.
class BriefExchange({
  /// The turn the app sent.
  required final BriefTurn turn,

  /// The brief's A2UI messages, as the agent sent them.
  required final List<Map<String, Object?>> brief,
}) {
  /// Creates an exchange.
  this;

  /// Reads an exchange; throws [FormatException] if [json] is not one.
  factory BriefExchange.fromJson(Object? json) {
    final Map<String, Object?> exchange = JsonFields.asObject(json, 'exchange');

    return BriefExchange(
      turn: BriefTurn.fromJson(exchange['turn']),
      brief: [
        for (final message in JsonFields.list(exchange, 'brief'))
          JsonFields.asObject(message, 'A2UI message'),
      ],
    );
  }
}
