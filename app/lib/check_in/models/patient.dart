import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// A person on today's list; the clinical data is in `ClinicalRecord`.
@immutable
class Patient {
  /// Stable identifier, shared with the patient's `ClinicalRecord`.
  final String id;

  /// Full name, e.g. `John Miller`.
  final String fullName;

  /// Age in years at the time of the visit.
  final int age;

  /// Recorded sex.
  final String sex;

  /// How the appointment was booked, e.g. `Same-day slot`.
  final String slotLabel;

  /// Scheduled start, e.g. `14:20`.
  final String slotTime;

  /// The clinician holding the slot.
  final String attendingDoctor;

  /// `John Miller, 61`.
  String get nameAndAge => '$fullName, $age';

  /// `Same-day slot · 14:20 · Dr. Thompson`.
  String get appointment =>
      '$slotLabel \u00b7 $slotTime \u00b7 $attendingDoctor';

  /// Creates a patient.
  const Patient({
    required this.id,
    required this.fullName,
    required this.age,
    required this.sex,
    required this.slotLabel,
    required this.slotTime,
    required this.attendingDoctor,
  });

  /// Reads a patient from its stored form.
  factory Patient.fromJson(Map<String, Object?> json) => Patient(
    id: json.readString('id'),
    fullName: json.readString('fullName'),
    age: json.readInt('age'),
    sex: json.readString('sex'),
    slotLabel: json.readString('slotLabel'),
    slotTime: json.readString('slotTime'),
    attendingDoctor: json.readString('attendingDoctor'),
  );

  /// The stored form of this patient.
  Map<String, Object?> toJson() => <String, Object?>{
    'id': id,
    'fullName': fullName,
    'age': age,
    'sex': sex,
    'slotLabel': slotLabel,
    'slotTime': slotTime,
    'attendingDoctor': attendingDoctor,
  };
}
