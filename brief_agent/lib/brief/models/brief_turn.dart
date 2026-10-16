import 'package:brief_agent/common/utils/json_fields.dart';

/// What the app asks for: the opening brief, a new brief after a finding,
/// or an answer to an action on the brief on screen.
sealed class const BriefTurn() {
  static const _type = 'type';
  static const _complaint = 'complaint';

  /// Reads a turn; throws [FormatException] if [json] is not one.
  factory BriefTurn.fromJson(Object? json) {
    final turn = JsonFields.asObject(json, 'turn');
    return switch (turn[_type]) {
      'opening' => OpeningTurn(
        today: JsonFields.string(turn, 'today'),
        patient: JsonFields.object(turn, 'patient'),
        record: JsonFields.object(turn, 'record'),
        complaint: JsonFields.object(turn, _complaint),
      ),
      'amendment' => AmendmentTurn(
        complaint: JsonFields.object(turn, _complaint),
      ),
      'event' => RendererEventTurn(message: JsonFields.object(turn, 'message')),
      final Object? type => throw FormatException('Unknown turn type: $type'),
    };
  }
}

/// The first turn: the patient, the record and the complaint at check-in.
final class const OpeningTurn({
  /// The app's date, as `yyyy-MM-dd`.
  required final String today,

  /// The patient, as the app stores them.
  required final Map<String, Object?> patient,

  /// The whole record, as the app stores it.
  required final Map<String, Object?> record,

  /// The complaint written at check-in.
  required final Map<String, Object?> complaint,
}) extends BriefTurn {}

/// A turn after the doctor added a finding: the whole complaint so far.
final class const AmendmentTurn({
  /// The complaint, with every finding added during the exam.
  required final Map<String, Object?> complaint,
}) extends BriefTurn {}

/// A turn the renderer sent by itself: an action on the brief.
final class const RendererEventTurn({
  /// The A2UI message the renderer sent.
  required final Map<String, Object?> message,
}) extends BriefTurn {}
