import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// One line of the table, with its note under the medicine name.
class const MedicationTableRow({
  super.key,

  /// The medicine, or the column's heading.
  required final String name,

  /// The dose, or the column's heading.
  required final String dose,

  /// How it is taken, or the column's heading.
  required final String schedule,

  /// Style of the three cells.
  required final TextStyle? style,

  /// Optional muted line under the medicine.
  final String? note,

  /// How much attention the line should draw; flagged lines get an icon.
  final ClinicalTone tone = ClinicalTone.neutral,
}) extends StatelessWidget {
  static const int _nameFlex = 4;
  static const int _doseFlex = 2;
  static const int _scheduleFlex = 3;
  static const double _iconSize = 18.0;
  static const double _iconGap = 6.0;

  /// Creates a line.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? detail = note;
    final bool isFlagged = tone != ClinicalTone.neutral;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: _nameFlex,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (isFlagged) ...<Widget>[
                      Icon(
                        tone == ClinicalTone.critical
                            ? Icons.warning_amber_rounded
                            : Icons.error_outline,
                        size: _iconSize,
                        color: style?.color,
                      ),
                      const SizedBox(width: _iconGap),
                    ],
                    Flexible(
                      child: Text(
                        name,
                        style: isFlagged
                            ? style?.copyWith(fontWeight: FontWeight.w600)
                            : style,
                      ),
                    ),
                  ],
                ),
                if (detail != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: Text(detail, style: theme.mutedBodyMedium),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            flex: _doseFlex,
            child: Text(dose, style: style),
          ),
          Expanded(
            flex: _scheduleFlex,
            child: Text(schedule, style: style),
          ),
        ],
      ),
    );
  }
}
