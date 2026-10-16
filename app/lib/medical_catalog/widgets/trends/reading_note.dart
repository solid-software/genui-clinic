import 'package:clinical_brief/common/utils/number_formatting.dart';
import 'package:clinical_brief/medical_catalog/models/trend_point.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// The date, value and record note of the reading the doctor tapped.
class const ReadingNote({
  super.key,

  /// The reading tapped.
  required final TrendPoint point,

  /// Colour of the date and value, the chart's line colour.
  required final Color color,
}) extends StatelessWidget {
  /// Creates the note.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? note = point.note;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${point.label} \u00b7 '
            '${NumberFormatting.compact(point.value)}',
            style: theme.textTheme.titleSmall?.copyWith(color: color),
          ),
          if (note != null)
            Text(
              note,
              style: theme.mutedBodySmall,
            ),
        ],
      ),
    );
  }
}
