import 'dart:convert';

import 'package:brief_agent/brief/brief_instructions.dart';
import 'package:brief_agent/brief/models/brief_turn.dart';

/// The text the agent sends the model: the system prompt and each turn.
abstract final class BriefPrompt {
  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  static const String _resend =
      'Send the whole brief again in one <a2ui> block, following the '
      'Express rules exactly.';

  /// The system prompt for a consultation held on [today], ending with
  /// a2ui_agent's [formatPrompt]: the Express rules and the catalog.
  static String system({required String formatPrompt, required String today}) =>
      <String>[
        BriefInstructions.role,
        BriefInstructions.amendment,
        'Current Date: $today',
        ...BriefInstructions.limits,
        BriefInstructions.composition,
        formatPrompt,
      ].map((String fragment) => fragment.trim()).join('\n\n');

  /// What [turn] tells the model.
  static String turn(BriefTurn turn) => switch (turn) {
    OpeningTurn() => _opening(turn),
    AmendmentTurn(:final Map<String, Object?> complaint) => _amendment(
      complaint,
    ),
    RendererEventTurn(:final Map<String, Object?> message) =>
      'The doctor interacted with the brief:\n${jsonEncode(message)}',
  };

  /// The turn asking to resend a reply that could not be decoded, naming
  /// the [problem].
  static String repair(String problem) =>
      '''
Your previous reply could not be displayed, so the doctor saw a blank screen.
$problem

$_resend
''';

  /// The first turn: today's date, the patient, the complaint and the record.
  static String _opening(OpeningTurn turn) {
    final String payload = _encoder.convert(<String, Object?>{
      'today': turn.today,
      'patient': turn.patient,
      'complaint': turn.complaint,
      'record': turn.record,
    });

    return '''
Compose the brief for this consultation.

$payload
''';
  }

  /// The turn after the doctor adds a finding.
  static String _amendment(Map<String, Object?> complaint) =>
      '''
The complaint has grown during the exam. Decide again which data to show
first, against the whole complaint below, and compose a new brief following
recipe D. It must not look like the brief before it with a line added: the
layout changes, the new findings and their readings lead, and what no longer
earns its place comes out.

${_encoder.convert(complaint)}
''';
}
