import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// One bar in a `BarComparison`.
@immutable
class BarEntry {
  /// What the bar stands for.
  final String label;

  /// The plotted value.
  final double value;

  /// The value as it should read, e.g. `9.6 %`.
  final String? display;

  /// Creates a bar entry.
  const BarEntry({
    required this.label,
    required this.value,
    this.display,
  });

  /// Reads an entry from an A2UI component payload.
  factory BarEntry.fromJson(Map<String, Object?> json) => BarEntry(
    label: json.readString('label'),
    value: json.readDouble('value'),
    display: json.readOptionalString('display'),
  );
}
