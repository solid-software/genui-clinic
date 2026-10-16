import 'dart:async';

import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/common/di/service_locator.dart';
import 'package:clinical_brief/common/widgets/shell/app_shell.dart';
import 'package:clinical_brief/dashboard/state/dashboard_controller.dart';
import 'package:clinical_brief/dashboard/widgets/brief_body.dart';
import 'package:flutter/material.dart';

/// The second screen: the brief the model composed for this consultation.
class const DashboardScreen({
  super.key,

  /// The patient being seen.
  required final Patient patient,

  /// The complaint captured at intake.
  required final Complaint complaint,
}) extends StatefulWidget {
  /// Creates dashboard screen.
  this;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final _controller = DashboardController(
    composer: ServiceLocator.get(),
    repository: ServiceLocator.get(),
    patient: widget.patient,
    initialComplaint: widget.complaint,
  );

  @override
  void initState() {
    super.initState();

    unawaited(_controller.start());
  }

  @override
  Widget build(BuildContext context) => AppShell(
    section: .brief,
    briefLabel: widget.patient.fullName,
    child: ListenableBuilder(
      listenable: _controller,
      builder: (_, _) => BriefBody(
        controller: _controller,
        onRefine: _controller.addFinding,
      ),
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
