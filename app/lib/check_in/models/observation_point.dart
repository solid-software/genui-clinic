import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// One measurement in an `ObservationSeries`.
@immutable
class ObservationPoint {
  /// When the sample was taken.
  final DateTime takenAt;

  /// The measured value, in the series' unit.
  final double value;

  /// Who recorded it.
  final String recordedBy;

  /// Creates an observation point.
  const ObservationPoint({
    required this.takenAt,
    required this.value,
    required this.recordedBy,
  });

  /// Reads a point from its stored form.
  factory ObservationPoint.fromJson(Map<String, Object?> json) =>
      ObservationPoint(
        takenAt: json.readDate('takenAt'),
        value: json.readDouble('value'),
        recordedBy: json.readString('recordedBy'),
      );

  /// The stored form of this point.
  Map<String, Object?> toJson() => <String, Object?>{
    'takenAt': takenAt.toIso8601String(),
    'value': value,
    'recordedBy': recordedBy,
  };
}
