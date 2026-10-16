import 'package:clinical_brief/check_in/models/clinical_record.dart';
import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:meta/meta.dart';

/// What the app asks the brief agent for, in the form the agent reads
/// (`BriefTurn` in brief_agent/).
@immutable
class const BriefTurn._(final Map<String, Object?> _json) {
  static const _type = 'type';
  static const _opening = 'opening';
  static const _complaint = 'complaint';

  /// Length of `yyyy-MM-dd`.
  static const _isoDateLength = 10;

  /// Whether this turn opens the consultation, starting it over.
  bool get isOpening => _json[_type] == _opening;

  /// The first turn: today's date, the patient, the record and the complaint
  /// at check-in.
  factory BriefTurn.opening({
    required Patient patient,
    required ClinicalRecord record,
    required Complaint complaint,
    DateTime? today,
  }) => BriefTurn._({
    _type: _opening,
    'today': (today ?? .now()).toIso8601String().substring(0, _isoDateLength),
    'patient': patient.toJson(),
    'record': record.toJson(),
    _complaint: complaint.toJson(),
  });

  /// The turn after the doctor adds a finding: the whole complaint so far.
  factory BriefTurn.amendment(Complaint complaint) => BriefTurn._(
    {_type: 'amendment', _complaint: complaint.toJson()},
  );

  /// An action on the brief, which GenUI reports by itself, as the A2UI JSON
  /// message it sends.
  factory BriefTurn.rendererEvent(Map<String, Object?> message) =>
      BriefTurn._({_type: 'event', 'message': message});

  /// The form the agent reads.
  Map<String, Object?> toJson() => {..._json};
}
