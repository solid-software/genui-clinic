import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/common/widgets/initials_avatar.dart';
import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// One slot: the doctor, the time and patient, and a status pill.
class const DoctorRow({
  super.key,

  /// The patient booked into the doctor's slot.
  required final Patient patient,

  /// Whether the patient has been checked in.
  required final bool arrived,
}) extends StatelessWidget {
  /// Below this screen width the status goes under the name. Screen, not
  /// layout, width: the card can sit in an IntrinsicHeight, which a
  /// LayoutBuilder would break.
  static const double _compactMaxWidth = 520.0;

  /// Creates the row.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isCompact = MediaQuery.sizeOf(context).width < _compactMaxWidth;
    final Widget status = arrived
        ? PillChip(
            label: 'Patient checked in',
            color: theme.colorScheme.secondaryContainer,
            foreground: theme.colorScheme.onSecondaryContainer,
          )
        : const PillChip(label: 'Waiting for patient');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: <Widget>[
          InitialsAvatar(name: patient.attendingDoctor),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  patient.attendingDoctor,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${patient.slotTime} \u00b7 ${patient.fullName}',
                  style: theme.mutedBodyMedium,
                ),
                if (isCompact) ...<Widget>[
                  const SizedBox(height: AppSpacing.sm),
                  status,
                ],
              ],
            ),
          ),
          if (!isCompact) ...<Widget>[
            const SizedBox(width: AppSpacing.md),
            status,
          ],
        ],
      ),
    );
  }
}
