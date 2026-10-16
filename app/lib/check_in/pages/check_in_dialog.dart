import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/check_in/widgets/check_in_header.dart';
import 'package:clinical_brief/common/widgets/app_text_field.dart';
import 'package:clinical_brief/demo/data/demo_scenarios.dart';
import 'package:clinical_brief/demo/models/demo_scenario.dart';
import 'package:clinical_brief/demo/widgets/demo_prompt_panel.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// What reception types in before handing the patient over.
///
/// One free-text field on purpose: interpreting it is the model's job.
class const CheckInDialog({
  super.key,

  /// The patient being checked in.
  required final Patient patient,
}) extends StatefulWidget {
  static const double _width = 620.0;
  static const int _minLines = 3;
  static const int _maxLines = 6;

  /// Creates a check-in dialog.
  this;

  /// Shows the dialog; resolves to the complaint, or `null` if dismissed.
  static Future<Complaint?> show(BuildContext context, Patient patient) =>
      showDialog<Complaint>(
        context: context,
        builder: (_) => CheckInDialog(patient: patient),
      );

  @override
  State<CheckInDialog> createState() => _CheckInDialogState();
}

class _CheckInDialogState extends State<CheckInDialog> {
  final TextEditingController _complaint = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DemoScenario? scenario = DemoScenarios.forPatient(widget.patient.id);

    // Scrollable: header and content scroll as one on short screens, or
    // with the keyboard up; the buttons stay in view.
    return AlertDialog(
      scrollable: true,
      titlePadding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        AppSpacing.xxl,
        AppSpacing.xxl,
        0.0,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        AppSpacing.xl,
        AppSpacing.xxl,
        AppSpacing.sm,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.sm,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      title: CheckInHeader(patient: widget.patient),
      content: SizedBox(
        width: CheckInDialog._width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (scenario != null) ...<Widget>[
              DemoPromptPanel(
                intro:
                    'Try one, then the other: the same chart, shown '
                    'differently for each complaint.',
                prompts: <String>[
                  scenario.checkInText,
                  scenario.alternativeComplaint,
                ],
                onPick: _use,
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
            Text(
              'In the patient\u2019s own words. Add how long, and any '
              'vitals taken at the desk.',
              style: theme.mutedBodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField.multiline(
              controller: _complaint,
              labelText: 'Complaint',
              hintText: scenario?.checkInText,
              autofocus: true,
              minLines: CheckInDialog._minLines,
              maxLines: CheckInDialog._maxLines,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _submit,
          icon: const Icon(Icons.arrow_forward),
          iconAlignment: IconAlignment.end,
          label: const Text('Open the brief'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _complaint.dispose();
    super.dispose();
  }

  void _use(String prompt) {
    _complaint
      ..text = prompt
      ..selection = TextSelection.collapsed(offset: prompt.length);
  }

  void _submit() {
    final String text = _complaint.text.trim();
    if (text.isEmpty) {
      return;
    }

    Navigator.of(context).pop(Complaint(presentingText: text));
  }
}
