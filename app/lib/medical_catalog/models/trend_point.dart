import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// One plotted measurement inside a `TrendChart`.
@immutable
class TrendPoint {
  /// Axis label, e.g. `Mar 25`.
  final String label;

  /// Plotted value.
  final double value;

  /// What the record says about this reading, shown when the point is tapped.
  final String? note;

  /// Creates a trend point.
  const TrendPoint({required this.label, required this.value, this.note});

  /// Reads a point from an A2UI component payload.
  factory TrendPoint.fromJson(Map<String, Object?> json) => TrendPoint(
    label: json.readString('label'),
    value: json.readDouble('value'),
    note: json.readOptionalString('note'),
  );
}
