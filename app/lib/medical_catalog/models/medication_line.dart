import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// One row of a medication table.
@immutable
class MedicationLine {
  /// The medicine, e.g. `Apixaban`.
  final String name;

  /// The dose as written, e.g. `5 mg`.
  final String dose;

  /// How it is taken, e.g. `twice daily`.
  final String schedule;

  /// What the record says about it, e.g. `over the counter, since March`.
  final String? note;

  /// How much attention the row should draw.
  final ClinicalTone tone;

  /// Creates a medication line.
  const MedicationLine({
    required this.name,
    required this.dose,
    required this.schedule,
    this.note,
    this.tone = ClinicalTone.neutral,
  });

  /// Reads a line from an A2UI component payload.
  factory MedicationLine.fromJson(Map<String, Object?> json) => MedicationLine(
    name: json.readString('name'),
    dose: json.readString('dose'),
    schedule: json.readString('schedule'),
    note: json.readOptionalString('note'),
    tone: ClinicalTone.fromWire(json['tone']),
  );
}
