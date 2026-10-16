import 'package:clinical_brief/check_in/models/clinical_record.dart';
import 'package:clinical_brief/check_in/models/patient.dart';

/// Read access to the patient list and charts; the app never writes them.
abstract interface class PatientRepository {
  /// Returns today's list, ordered by slot time.
  Future<List<Patient>> fetchPatients();

  /// Returns the patient with [patientId], or `null` if none is stored.
  Future<Patient?> findPatient(String patientId);

  /// Returns the full chart for [patientId].
  Future<ClinicalRecord> fetchRecord(String patientId);
}
