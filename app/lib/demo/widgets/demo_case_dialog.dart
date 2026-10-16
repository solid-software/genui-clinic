import 'package:clinical_brief/common/widgets/app_dialog.dart';
import 'package:clinical_brief/demo/models/demo_scenario.dart';
import 'package:clinical_brief/demo/widgets/copyable_prompt.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// The demo prompts for the patient on screen; tapping one copies it.
class const DemoCaseDialog({
  super.key,

  /// The patient's name, for the title.
  required final String patientName,

  /// The prompts to offer.
  required final DemoScenario scenario,
}) extends StatelessWidget {
  static const _width = 560.0;

  /// Creates demo case dialog.
  this;

  /// Shows the dialog.
  static Future<void> show(
    BuildContext context, {
    required String patientName,
    required DemoScenario scenario,
  }) => showDialog(
    context: context,
    builder: (_) =>
        DemoCaseDialog(patientName: patientName, scenario: scenario),
  );

  @override
  Widget build(BuildContext context) => AppDialog(
    title: 'Demo case \u00b7 $patientName',
    width: _width,
    closeLabel: 'Close',
    content: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Text('Tap a text to copy it.', style: Theme.of(context).mutedBodySmall),
        CopyablePrompt(
          label: 'Paste into Refine, as if found during the exam',
          text: scenario.findingText,
        ),
        CopyablePrompt(
          label: 'Or go back and check in with another complaint',
          text: scenario.alternativeComplaint,
        ),
      ],
    ),
  );
}
