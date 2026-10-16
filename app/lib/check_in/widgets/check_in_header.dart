import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/check_in/widgets/appointment_chips.dart';
import 'package:clinical_brief/common/widgets/initials_avatar.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Who is being checked in: initials, name and the booked slot.
class const CheckInHeader({
  super.key,

  /// The patient being checked in.
  required final Patient patient,
}) extends StatelessWidget {
  static const double _avatarSize = 56.0;

  /// Creates the header.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        InitialsAvatar(name: patient.fullName, size: _avatarSize),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(patient.nameAndAge, style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.sm),
              AppointmentChips(patient: patient),
            ],
          ),
        ),
      ],
    );
  }
}
