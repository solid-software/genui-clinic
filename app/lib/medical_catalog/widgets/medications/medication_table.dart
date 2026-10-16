import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/common/widgets/divided_column.dart';
import 'package:clinical_brief/medical_catalog/models/medication_line.dart';
import 'package:clinical_brief/medical_catalog/widgets/medications/medication_table_row.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// The medication list as a table: medicine, dose, how it is taken.
///
/// A flagged row takes its tone's colour and an icon before the name.
class const MedicationTable({
  super.key,

  /// The rows, in the order the model ranked them.
  required final List<MedicationLine> medications,
}) extends StatelessWidget {
  /// Creates a medication table.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: <Widget>[
        MedicationTableRow(
          name: 'Medicine',
          dose: 'Dose',
          schedule: 'How it is taken',
          style: theme.mutedBodyMedium,
        ),
        // The header keeps its line even when no medicine is listed.
        DividedColumn(
          hasLeadingDivider: true,
          children: <Widget>[
            for (final MedicationLine line in medications)
              MedicationTableRow(
                name: line.name,
                dose: line.dose,
                schedule: line.schedule,
                note: line.note,
                tone: line.tone,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: line.tone == ClinicalTone.neutral
                      ? theme.colorScheme.onSurface
                      : line.tone.foregroundOf(context),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
