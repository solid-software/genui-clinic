import 'package:clinical_brief/common/utils/number_formatting.dart';
import 'package:clinical_brief/medical_catalog/models/bar_entry.dart';
import 'package:clinical_brief/medical_catalog/widgets/bar_comparison/comparison_bar.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Values compared as bars, with an optional target marked.
class const BarComparison({
  super.key,

  /// The bars, in the order the model ranked them.
  required final List<BarEntry> entries,

  /// Optional target drawn as a vertical line across the bars.
  final double? target,

  /// What the target is, e.g. `target below 7%`.
  final String? targetLabel,
}) extends StatelessWidget {
  static const double _labelWidth = 150.0;
  static const double _valueWidth = 72.0;

  /// Creates a bar comparison.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? note = targetLabel;
    final double maximum = _maximum();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final BarEntry entry in entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: _labelWidth,
                  child: Text(entry.label, style: theme.textTheme.bodyMedium),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ComparisonBar(
                    fraction: maximum == 0 ? 0 : entry.value / maximum,
                    targetFraction: target == null || maximum == 0
                        ? null
                        : (target ?? 0) / maximum,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                SizedBox(
                  width: _valueWidth,
                  child: Text(
                    entry.display ?? NumberFormatting.compact(entry.value),
                    textAlign: TextAlign.end,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        if (note != null) ...<Widget>[
          const SizedBox(height: AppSpacing.sm),
          Text(
            note,
            style: theme.mutedBodySmall,
          ),
        ],
      ],
    );
  }

  double _maximum() {
    double maximum = target ?? 0;
    for (final BarEntry entry in entries) {
      maximum = entry.value > maximum ? entry.value : maximum;
    }

    return maximum;
  }
}
