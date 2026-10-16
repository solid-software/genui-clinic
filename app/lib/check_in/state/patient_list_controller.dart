import 'package:clinical_brief/check_in/models/check_in.dart';
import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/check_in/repository/patient_repository.dart';
import 'package:clinical_brief/common/logging/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// Loads today's list and keeps the search and this session's check-ins.
class PatientListController extends ChangeNotifier {
  final PatientRepository _repository;
  final Logger _log = AppLogger.of('PatientListController');

  List<Patient> _patients = const <Patient>[];
  List<CheckIn> _checkIns = const <CheckIn>[];
  String _query = '';
  String? _errorMessage;
  bool _isLoading = true;

  /// Today's list, ordered by slot time.
  List<Patient> get patients => List<Patient>.unmodifiable(_patients);

  /// Today's list, narrowed to the names that match the search.
  List<Patient> get matchingPatients {
    final String query = _query.toLowerCase();

    return List<Patient>.unmodifiable(
      query.isEmpty
          ? _patients
          : _patients.where(
              (patient) => patient.fullName.toLowerCase().contains(query),
            ),
    );
  }

  /// Patients not checked in yet, in slot order.
  List<Patient> get waitingPatients => List<Patient>.unmodifiable(
    _patients.where((patient) => !isCheckedIn(patient)),
  );

  /// This session's check-ins, newest first.
  List<CheckIn> get checkIns => List<CheckIn>.unmodifiable(_checkIns);

  /// The search as typed, trimmed.
  String get query => _query;

  /// Why loading failed, or `null`.
  String? get errorMessage => _errorMessage;

  /// Whether the first load is still running.
  bool get isLoading => _isLoading;

  /// Creates a controller over the given repository.
  PatientListController(this._repository);

  /// Loads the list. Safe to call again to retry.
  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _patients = await _repository.fetchPatients();
    } on Exception catch (exception, stackTrace) {
      _log.severe('Could not load patients', exception, stackTrace);
      _errorMessage = 'Could not read the patients stored on this device.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Narrows the list to names containing [query].
  void search(String query) {
    _query = query.trim();
    notifyListeners();
  }

  /// Records that [patient] was checked in with [complaint] just now.
  void recordCheckIn(Patient patient, Complaint complaint) {
    _checkIns = <CheckIn>[
      CheckIn(patient: patient, complaint: complaint, at: DateTime.now()),
      ..._checkIns,
    ];
    notifyListeners();
  }

  /// Whether [patient] was checked in this session.
  bool isCheckedIn(Patient patient) =>
      _checkIns.any((checkIn) => checkIn.patient.id == patient.id);
}
