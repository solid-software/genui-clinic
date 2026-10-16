import 'dart:async';

import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/check_in/pages/check_in_dialog.dart';
import 'package:clinical_brief/check_in/state/patient_list_controller.dart';
import 'package:clinical_brief/check_in/widgets/patient_list_body.dart';
import 'package:clinical_brief/common/di/service_locator.dart';
import 'package:clinical_brief/common/routes/dashboard_link.dart';
import 'package:clinical_brief/common/widgets/shell/app_shell.dart';
import 'package:clinical_brief/common/widgets/shell/demo_disclaimer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The first screen: today's list, at the front desk.
class const PatientListScreen({super.key}) extends StatefulWidget {
  /// Creates check-in screen
  this;

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  late final _controller = PatientListController(ServiceLocator.get());
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    unawaited(_controller.load());
  }

  @override
  Widget build(BuildContext context) => AppShell(
    section: .checkIn,
    footer: const DemoDisclaimer(),
    child: ListenableBuilder(
      listenable: _controller,
      builder: (_, _) => PatientListBody(
        controller: _controller,
        search: _search,
        onCheckIn: _checkIn,
      ),
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    _search.dispose();
    super.dispose();
  }

  Future<void> _checkIn(Patient patient) async {
    final complaint = await CheckInDialog.show(context, patient);
    if (complaint == null || !mounted) return;
    _controller.recordCheckIn(patient, complaint);
    // Pushed, so the list and this session's check-ins stay underneath.
    unawaited(
      context.push(
        DashboardLink(
          patientId: patient.id,
          complaint: complaint.presentingText,
        ).location,
      ),
    );
  }
}
