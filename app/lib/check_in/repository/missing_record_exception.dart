/// Thrown when no chart is stored for a patient.
class MissingRecordException implements Exception {
  /// The patient whose chart is missing.
  final String patientId;

  /// Creates the exception.
  const MissingRecordException(this.patientId);

  @override
  String toString() => 'No chart stored for patient "$patientId".';
}
