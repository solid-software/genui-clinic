import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// One patient: slot time, name and doctor, and the check-in button.
class const WaitingRow({
  super.key,

  /// The patient waiting.
  required final Patient patient,

  /// Whether the patient was checked in this session.
  required final bool checkedIn,

  /// Called to check the patient in.
  required final VoidCallback onCheckIn,
}) extends StatelessWidget {
  static const _compactMaxWidth = 520.0;
  static const _timeWidth = 76.0;
  static const _lineGap = 2.0;

  /// Creates the row.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final button = checkedIn
        ? OutlinedButton(
            onPressed: onCheckIn,
            child: const Text('Check in again'),
          )
        : FilledButton(onPressed: onCheckIn, child: const Text('Check in'));

    final details = Column(
      spacing: _lineGap,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          patient.nameAndAge,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '${patient.attendingDoctor} \u00b7 ${patient.slotLabel}',
          style: theme.mutedBodyMedium,
        ),
      ],
    );

    final time = SizedBox(
      width: _timeWidth,
      child: Center(child: PillChip(label: patient.slotTime, prominent: true)),
    );

    return InkWell(
      borderRadius: BorderRadius.circular(AppSpacing.tileRadius),
      onTap: onCheckIn,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: LayoutBuilder(
          builder: (_, constraints) => constraints.maxWidth < _compactMaxWidth
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: [
                        time,
                        const SizedBox(width: AppSpacing.md),
                        Expanded(child: details),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Align(alignment: Alignment.centerRight, child: button),
                  ],
                )
              : Row(
                  children: [
                    time,
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(child: details),
                    if (checkedIn) ...[
                      PillChip(
                        label: 'Checked in',
                        icon: Icons.check,
                        color: theme.colorScheme.secondaryContainer,
                        foreground: theme.colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: AppSpacing.md),
                    ],
                    button,
                  ],
                ),
        ),
      ),
    );
  }
}
