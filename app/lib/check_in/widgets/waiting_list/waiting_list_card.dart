import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/check_in/widgets/waiting_list/waiting_row.dart';
import 'package:clinical_brief/common/widgets/divided_column.dart';
import 'package:clinical_brief/common/widgets/panel_card.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Today's patients by slot time, each with a button to check them in.
class const WaitingListCard({
  super.key,

  /// The patients to list, already filtered by the search.
  required final List<Patient> patients,

  /// What was searched for, to explain an empty list.
  required final String query,

  /// Whether a patient was checked in this session.
  required final bool Function(Patient patient) isCheckedIn,

  /// Called to check a patient in.
  required final ValueChanged<Patient> onCheckIn,
}) extends StatelessWidget {
  /// Creates the card.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PanelCard(
      icon: Icons.schedule,
      title: 'Waiting list',
      subtitle: 'By slot time',
      child: DividedColumn(
        hasLeadingDivider: true,
        crossAxisAlignment: .stretch,
        children: [
          if (patients.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
              child: Text(
                query.isEmpty
                    ? 'No patients on today\u2019s list.'
                    : 'No patient matches \u201c$query\u201d.',
                style: theme.mutedBodyMedium,
              ),
            ),
          for (final patient in patients)
            WaitingRow(
              patient: patient,
              checkedIn: isCheckedIn(patient),
              onCheckIn: () => onCheckIn(patient),
            ),
        ],
      ),
    );
  }
}
