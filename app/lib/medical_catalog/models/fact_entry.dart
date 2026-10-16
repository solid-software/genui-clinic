import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// One labelled line inside a `FactList`.
@immutable
class FactEntry {
  /// What the fact is, e.g. `Smoking`.
  final String label;

  /// What it says, e.g. `30 pack-years`.
  final String? value;

  /// Provenance or recency, e.g. `last recorded 2019`.
  final String? meta;

  /// How much attention the line should draw.
  final ClinicalTone tone;

  /// Creates a fact entry.
  const FactEntry({
    required this.label,
    this.value,
    this.meta,
    this.tone = ClinicalTone.neutral,
  });

  /// Reads an entry from an A2UI component payload.
  factory FactEntry.fromJson(Map<String, Object?> json) => FactEntry(
    label: json.readString('label'),
    value: json.readOptionalString('value'),
    meta: json.readOptionalString('meta'),
    tone: ClinicalTone.fromWire(json['tone']),
  );
}
