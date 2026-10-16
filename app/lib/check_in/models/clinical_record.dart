import 'package:clinical_brief/check_in/models/imaging_study.dart';
import 'package:clinical_brief/check_in/models/medical_condition.dart';
import 'package:clinical_brief/check_in/models/medication.dart';
import 'package:clinical_brief/check_in/models/observation_series.dart';
import 'package:clinical_brief/check_in/models/risk_factor.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// Everything on file for one patient.
@immutable
class ClinicalRecord {
  /// Id of the patient this record belongs to.
  final String patientId;

  /// Known allergies; empty means none known.
  final List<String> allergies;

  /// Active prescriptions.
  final List<Medication> medications;

  /// Diagnoses on the chart.
  final List<MedicalCondition> conditions;

  /// Quantities measured over time.
  final List<ObservationSeries> observations;

  /// Radiology on file.
  final List<ImagingStudy> imaging;

  /// Long-lived risks such as smoking.
  final List<RiskFactor> riskFactors;

  /// Entries on file, counting each series once.
  int get entryCount =>
      allergies.length +
      medications.length +
      conditions.length +
      observations.length +
      imaging.length +
      riskFactors.length;

  /// Creates a clinical record.
  const ClinicalRecord({
    required this.patientId,
    this.allergies = const <String>[],
    this.medications = const <Medication>[],
    this.conditions = const <MedicalCondition>[],
    this.observations = const <ObservationSeries>[],
    this.imaging = const <ImagingStudy>[],
    this.riskFactors = const <RiskFactor>[],
  });

  /// Reads a record from its stored form.
  factory ClinicalRecord.fromJson(Map<String, Object?> json) => ClinicalRecord(
    patientId: json.readString('patientId'),
    allergies: json.readStringList('allergies'),
    medications: json.readList('medications', Medication.fromJson),
    conditions: json.readList('conditions', MedicalCondition.fromJson),
    observations: json.readList('observations', ObservationSeries.fromJson),
    imaging: json.readList('imaging', ImagingStudy.fromJson),
    riskFactors: json.readList('riskFactors', RiskFactor.fromJson),
  );

  /// The stored form of this record.
  Map<String, Object?> toJson() => <String, Object?>{
    'patientId': patientId,
    'allergies': allergies,
    'medications': <Object?>[
      for (final Medication drug in medications) drug.toJson(),
    ],
    'conditions': <Object?>[
      for (final MedicalCondition condition in conditions) condition.toJson(),
    ],
    'observations': <Object?>[
      for (final ObservationSeries series in observations) series.toJson(),
    ],
    'imaging': <Object?>[
      for (final ImagingStudy study in imaging) study.toJson(),
    ],
    'riskFactors': <Object?>[
      for (final RiskFactor factor in riskFactors) factor.toJson(),
    ],
  };
}
