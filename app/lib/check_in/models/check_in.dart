import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:meta/meta.dart';

/// A patient handed over to the doctor in this session, with why they came.
@immutable
class CheckIn {
  /// Who was checked in.
  final Patient patient;

  /// What reception wrote down.
  final Complaint complaint;

  /// When the brief was opened.
  final DateTime at;

  /// Creates a check-in.
  const CheckIn({
    required this.patient,
    required this.complaint,
    required this.at,
  });
}
