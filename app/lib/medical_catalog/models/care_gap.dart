import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// One item the record says is due, overdue or never done.
@immutable
class CareGap {
  /// What it is, e.g. `Colonoscopy repeat`.
  final String item;

  /// When it was due or last done, e.g. `due 2021`.
  final String due;

  /// Where that stands, e.g. `never booked`.
  final String? status;

  /// How much attention the row should draw.
  final ClinicalTone tone;

  /// Creates a care gap.
  const CareGap({
    required this.item,
    required this.due,
    this.status,
    this.tone = ClinicalTone.neutral,
  });

  /// Reads a gap from an A2UI component payload.
  factory CareGap.fromJson(Map<String, Object?> json) => CareGap(
    item: json.readString('item'),
    due: json.readString('due'),
    status: json.readOptionalString('status'),
    tone: ClinicalTone.fromWire(json['tone']),
  );
}
