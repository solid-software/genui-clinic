import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// An active prescription.
@immutable
class Medication {
  /// Substance name, e.g. `Amlodipine`.
  final String name;

  /// Dose as written on the prescription, e.g. `10 mg`.
  final String dose;

  /// Dosing schedule, e.g. `once daily`.
  final String schedule;

  /// Whether the drug is an anticoagulant, checked before anything invasive.
  final bool isAnticoagulant;

  /// `Amlodipine 10 mg`.
  String get label => '$name $dose';

  /// Creates a medication.
  const Medication({
    required this.name,
    required this.dose,
    required this.schedule,
    this.isAnticoagulant = false,
  });

  /// Reads a medication from its stored form.
  factory Medication.fromJson(Map<String, Object?> json) => Medication(
    name: json.readString('name'),
    dose: json.readString('dose'),
    schedule: json.readString('schedule'),
    isAnticoagulant: json.readBool('isAnticoagulant'),
  );

  /// The stored form of this medication.
  Map<String, Object?> toJson() => <String, Object?>{
    'name': name,
    'dose': dose,
    'schedule': schedule,
    'isAnticoagulant': isAnticoagulant,
  };
}
