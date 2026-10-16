import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/check_in/repository/patient_repository.dart';
import 'package:clinical_brief/common/di/service_locator.dart';
import 'package:clinical_brief/common/logging/app_logger.dart';
import 'package:clinical_brief/common/routes/app_routes.dart';
import 'package:clinical_brief/common/routes/dashboard_link.dart';
import 'package:clinical_brief/common/widgets/shell/app_shell.dart';
import 'package:clinical_brief/dashboard/pages/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Opens a [DashboardLink]: finds the patient, then shows [DashboardScreen].
///
/// A patient who is not on the list sends the doctor back to check-in.
class const DashboardLoader({
  super.key,

  /// The link being opened.
  required final DashboardLink link,
}) extends StatefulWidget {
  /// Creates dashboard loader view
  this;

  @override
  State<DashboardLoader> createState() => _DashboardLoaderState();
}

class _DashboardLoaderState extends State<DashboardLoader> {
  final _log = AppLogger.of('DashboardLoader');
  late final _patient = _findPatient();

  @override
  Widget build(BuildContext context) => FutureBuilder<Patient?>(
    future: _patient,
    builder: (_, snapshot) => switch (snapshot.data) {
      null => const AppShell(
        section: .brief,
        child: Center(child: CircularProgressIndicator()),
      ),
      final patient => DashboardScreen(
        patient: patient,
        complaint: Complaint(presentingText: widget.link.complaint),
      ),
    },
  );

  /// Seeds only when the patient is missing: a link can be the first screen
  /// of a fresh install.
  Future<Patient?> _findPatient() async {
    final repository = ServiceLocator.get<PatientRepository>();
    final patientId = widget.link.patientId;

    try {
      if (await repository.findPatient(patientId) case final p?) return p;
      _log.warning('No patient "$patientId" on the list.');
    } on Exception catch (error, stackTrace) {
      _log.severe('Could not read patient "$patientId"', error, stackTrace);
    }
    if (mounted) {
      // Replaces the bad link in the browser history, so Back skips it.
      Router.neglect(context, () => context.go(AppRoutes.checkIn));
    }

    return null;
  }
}
