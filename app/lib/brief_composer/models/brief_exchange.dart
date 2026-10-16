import 'package:clinical_brief/brief_composer/models/brief_turn.dart';
import 'package:meta/meta.dart';

/// A turn the agent answered and the brief it answered with, in A2UI JSON:
/// how the app holds the consultation (`BriefExchange` in brief_agent/).
@immutable
class const BriefExchange({
  /// The turn the app sent.
  required final BriefTurn turn,

  /// The brief's A2UI messages, as the agent sent them.
  required final List<Map<String, Object?>> brief,
}) {
  /// Creates an exchange.
  this;

  /// The form the agent reads.
  Map<String, Object?> toJson() => {
    'turn': turn.toJson(),
    'brief': brief,
  };
}
