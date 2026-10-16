import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// One flagged result inside a `LabPanel`.
@immutable
class LabResult {
  /// What was measured, e.g. `Ferritin`.
  final String name;

  /// The value with its unit, e.g. `18 ng/mL`.
  final String value;

  /// The normal range as written, e.g. `ref 20 - 200`.
  final String? referenceRange;

  /// Where the value sits, e.g. `Below range`.
  final String status;

  /// Earlier values for context, e.g. `was 12.4 in Jan 2026`.
  final String? history;

  /// How much attention the row should draw.
  final ClinicalTone tone;

  /// Creates a lab result.
  const LabResult({
    required this.name,
    required this.value,
    required this.status,
    this.referenceRange,
    this.history,
    this.tone = ClinicalTone.warning,
  });

  /// Reads a result from an A2UI component payload.
  factory LabResult.fromJson(Map<String, Object?> json) => LabResult(
    name: json.readString('name'),
    value: json.readString('value'),
    status: json.readString('status'),
    referenceRange: json.readOptionalString('referenceRange'),
    history: json.readOptionalString('history'),
    tone: ClinicalTone.fromWire(json['tone']),
  );
}
