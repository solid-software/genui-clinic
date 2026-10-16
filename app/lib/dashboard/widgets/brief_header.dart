import 'package:clinical_brief/dashboard/state/dashboard_controller.dart';
import 'package:clinical_brief/dashboard/widgets/header/dashboard_header.dart';
import 'package:clinical_brief/dashboard/widgets/header/refine_field.dart';
import 'package:clinical_brief/demo/data/demo_scenarios.dart';
import 'package:clinical_brief/demo/widgets/demo_case_dialog.dart';
import 'package:flutter/material.dart';

/// The patient, the refine field and the complaint chips.
class const BriefHeader({
  super.key,

  /// The consultation on screen.
  required final DashboardController controller,

  /// Called with a finding the doctor typed into the refine field.
  required final ValueChanged<String> onRefine,
}) extends StatelessWidget {
  /// Creates brief header
  this;

  @override
  Widget build(BuildContext context) {
    final scenario = DemoScenarios.forPatient(controller.patient.id);

    return DashboardHeader(
      patient: controller.patient,
      complaint: controller.complaint,
      refineField: RefineField(
        onSubmit: onRefine,
        enabled: !controller.isComposing,
      ),
      onShowDemoCase: scenario == null
          ? null
          : () => DemoCaseDialog.show(
              context,
              patientName: controller.patient.fullName,
              scenario: scenario,
            ),
    );
  }
}
