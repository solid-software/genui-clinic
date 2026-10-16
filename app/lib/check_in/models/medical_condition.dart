import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// A diagnosis already on the chart.
@immutable
class MedicalCondition {
  /// Diagnosis name, e.g. `Type 2 diabetes`.
  final String name;

  /// Year of diagnosis.
  final int since;

  /// Optional free-text detail.
  final String? detail;

  /// Creates a condition.
  const MedicalCondition({
    required this.name,
    required this.since,
    this.detail,
  });

  /// Reads a condition from its stored form.
  factory MedicalCondition.fromJson(Map<String, Object?> json) =>
      MedicalCondition(
        name: json.readString('name'),
        since: json.readInt('since'),
        detail: json.readOptionalString('detail'),
      );

  /// The stored form of this condition.
  Map<String, Object?> toJson() => <String, Object?>{
    'name': name,
    'since': since,
    'detail': detail,
  };
}
