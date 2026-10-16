import 'package:clinical_brief/common/widgets/divided_column.dart';
import 'package:clinical_brief/dashboard/widgets/full_record/record_row.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// One group of the record, styled like the brief's own cards.
class const RecordCard({
  super.key,

  /// The group's name, e.g. `Allergies`.
  required final String title,

  /// The entries, top to bottom.
  required final List<RecordRow> rows,

  /// Optional note at the end of the title, e.g. a unit.
  final String? titleTrailing,
}) extends StatelessWidget {
  /// Creates record card.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTrailing = this.titleTrailing;

    // Tinted on the white panel, so each group reads as its own block.
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSpacing.tileRadius),
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title, style: theme.textTheme.titleMedium),
              ),
              if (titleTrailing != null)
                Text(
                  titleTrailing,
                  style: theme.mutedBodySmall,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          DividedColumn(
            dividerHeight: 1.0,
            dividerColor: theme.colorScheme.outlineVariant,
            crossAxisAlignment: .stretch,
            children: rows,
          ),
        ],
      ),
    );
  }
}
