import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/check_in/widgets/appointment_chips.dart';
import 'package:clinical_brief/common/widgets/initials_avatar.dart';
import 'package:clinical_brief/demo/widgets/demo_case_button.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Initials, name, the demo-case button and, when wide, the appointment.
class const HeaderTitleRow({
  super.key,

  /// The patient being seen.
  required final Patient patient,

  /// Whether there is room for the appointment beside the name.
  required final bool isWide,

  /// Opens the demo case; the button is hidden when `null`.
  final VoidCallback? onShowDemoCase,
}) extends StatelessWidget {
  static const _avatarSize = 64.0;
  static const _wideNameSize = 44.0;

  /// Creates header title row
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onShowDemoCase = this.onShowDemoCase;
    final nameStyle = isWide
        ? theme.textTheme.displaySmall?.copyWith(fontSize: _wideNameSize)
        : theme.textTheme.headlineMedium;
    final appointment = AppointmentChips.prominent(patient: patient);

    return Column(
      crossAxisAlignment: .start,
      spacing: AppSpacing.md,
      children: [
        Row(
          children: [
            InitialsAvatar(
              name: patient.fullName,
              size: _avatarSize,
              color: theme.colorScheme.surface,
            ),
            const SizedBox(width: AppSpacing.lg),
            // Expanded, so the appointment ends flush with the card.
            Expanded(
              child: Row(
                spacing: AppSpacing.sm,
                children: [
                  Flexible(child: Text(patient.nameAndAge, style: nameStyle)),
                  if (onShowDemoCase != null)
                    DemoCaseButton(onPressed: onShowDemoCase),
                ],
              ),
            ),
            if (isWide) ...[
              const SizedBox(width: AppSpacing.md),
              appointment,
            ],
          ],
        ),
        if (!isWide) appointment,
      ],
    );
  }
}
