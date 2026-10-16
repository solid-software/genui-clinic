import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// A long-lived risk such as smoking, often recorded once and forgotten.
@immutable
class RiskFactor {
  /// Factor name, e.g. `Smoking`.
  final String name;

  /// Quantified detail, e.g. `30 pack-years`.
  final String detail;

  /// Year the factor was last confirmed with the patient.
  final int lastRecordedYear;

  /// Creates a risk factor.
  const RiskFactor({
    required this.name,
    required this.detail,
    required this.lastRecordedYear,
  });

  /// Reads a risk factor from its stored form.
  factory RiskFactor.fromJson(Map<String, Object?> json) => RiskFactor(
    name: json.readString('name'),
    detail: json.readString('detail'),
    lastRecordedYear: json.readInt('lastRecordedYear'),
  );

  /// The stored form of this risk factor.
  Map<String, Object?> toJson() => <String, Object?>{
    'name': name,
    'detail': detail,
    'lastRecordedYear': lastRecordedYear,
  };
}
