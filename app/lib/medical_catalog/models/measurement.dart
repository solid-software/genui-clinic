import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// One measurement tile: a number taken today, shown large.
@immutable
class Measurement {
  /// What was measured, e.g. `Oxygen saturation`.
  final String label;

  /// The reading as written, e.g. `89%`.
  final String value;

  /// Where it sits against what came before, e.g. `was 95% at check-in`.
  final String? meta;

  /// How much attention the tile should draw.
  final ClinicalTone tone;

  /// Creates a measurement.
  const Measurement({
    required this.label,
    required this.value,
    this.meta,
    this.tone = ClinicalTone.neutral,
  });

  /// Reads a measurement from an A2UI component payload.
  factory Measurement.fromJson(Map<String, Object?> json) => Measurement(
    label: json.readString('label'),
    value: json.readString('value'),
    meta: json.readOptionalString('meta'),
    tone: ClinicalTone.fromWire(json['tone']),
  );
}
