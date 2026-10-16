import 'package:clinical_brief/check_in/models/observation_point.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// A quantity measured over time, such as haemoglobin or weight.
@immutable
class ObservationSeries {
  /// Stable machine name, e.g. `hemoglobin`.
  final String code;

  /// Human label, e.g. `Hemoglobin`.
  final String displayName;

  /// Unit of measure, e.g. `g/L`.
  final String unit;

  /// Lower bound of the normal range, when one applies.
  final double? referenceLow;

  /// Upper bound of the normal range, when one applies.
  final double? referenceHigh;

  /// Measurements, oldest first.
  final List<ObservationPoint> points;

  /// Creates a series.
  const ObservationSeries({
    required this.code,
    required this.displayName,
    required this.unit,
    required this.points,
    this.referenceLow,
    this.referenceHigh,
  });

  /// Reads a series from its stored form.
  factory ObservationSeries.fromJson(Map<String, Object?> json) =>
      ObservationSeries(
        code: json.readString('code'),
        displayName: json.readString('displayName'),
        unit: json.readString('unit'),
        points: json.readList('points', ObservationPoint.fromJson),
        referenceLow: json.readOptionalDouble('referenceLow'),
        referenceHigh: json.readOptionalDouble('referenceHigh'),
      );

  /// The stored form of this series.
  Map<String, Object?> toJson() => <String, Object?>{
    'code': code,
    'displayName': displayName,
    'unit': unit,
    'referenceLow': referenceLow,
    'referenceHigh': referenceHigh,
    'points': <Object?>[
      for (final ObservationPoint point in points) point.toJson(),
    ],
  };
}
