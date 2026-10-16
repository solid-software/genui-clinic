import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The booked slot: how it was booked, the time, and the doctor.
class AppointmentChips extends StatelessWidget {
  /// Whose appointment it is.
  final Patient patient;

  final bool _isProminent;

  /// Small pills, as in the check-in dialog.
  const AppointmentChips({super.key, required this.patient})
    : _isProminent = false;

  /// Larger pills, the outer two white, as on the brief's hero.
  const AppointmentChips.prominent({super.key, required this.patient})
    : _isProminent = true;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final fill = _isProminent ? colors.surface : null;

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        PillChip(
          label: patient.slotLabel,
          color: fill,
          prominent: _isProminent,
        ),
        PillChip(
          label: patient.slotTime,
          color: colors.tertiaryContainer,
          foreground: colors.onTertiaryContainer,
          prominent: _isProminent,
        ),
        PillChip(
          label: patient.attendingDoctor,
          color: fill,
          prominent: _isProminent,
        ),
      ],
    );
  }
}
