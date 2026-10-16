import 'package:clinical_brief/common/widgets/divided_column.dart';
import 'package:clinical_brief/medical_catalog/models/fact_entry.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// A list of chart lines: what it is, what it says, how stale it is.
class const FactList({
  super.key,

  /// Lines to show, in the order the model ranked them.
  required final List<FactEntry> entries,
}) extends StatelessWidget {
  static const int _labelFlex = 3;
  static const int _valueFlex = 3;
  static const int _metaFlex = 2;

  /// Creates a fact list.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DividedColumn(
      crossAxisAlignment: .start,
      children: [
        for (final entry in entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Row(
              crossAxisAlignment: .baseline,
              textBaseline: .alphabetic,
              children: [
                Expanded(
                  flex: _labelFlex,
                  child: Text(
                    entry.label,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: entry.tone.foregroundOf(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (entry.value != null)
                  Expanded(
                    flex: _valueFlex,
                    child: Text(
                      entry.value ?? '',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                if (entry.meta != null)
                  Expanded(
                    flex: _metaFlex,
                    child: Text(
                      entry.meta ?? '',
                      textAlign: .end,
                      style: theme.mutedBodySmall,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
