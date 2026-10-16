import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:clinical_brief/medical_catalog/models/fact_entry.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// One labelled value of the banner: chips for a list, large type for the
/// rest.
class const SafetyBannerEntry({
  super.key,

  /// The label and value shown.
  required final FactEntry entry,

  /// Colour of the label, the value and the chips' text.
  required final Color accent,
}) extends StatelessWidget {
  /// The fewest items a value needs to be shown as chips.
  static const int minListItems = 3;

  static const double _labelGap = 6.0;

  /// Commas and semicolons outside brackets, as in `Metformin 1000 mg,
  /// Lisinopril 20 mg` but not `Penicillin (hives, rash)`.
  static final RegExp _separator = RegExp(r'[,;]\s*(?![^()]*\))');

  /// Creates the entry.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<String> items = itemsOf(entry);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            entry.label,
            style: theme.textTheme.labelLarge?.copyWith(color: accent),
          ),
          const SizedBox(height: _labelGap),
          if (items.length >= minListItems)
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: <Widget>[
                for (final String item in items)
                  PillChip(
                    label: item,
                    color: theme.colorScheme.surface,
                    foreground: accent,
                    prominent: true,
                  ),
              ],
            )
          else
            Text(
              entry.value ?? '\u2013',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: accent,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
    );
  }

  /// The items [entry]'s value lists, or the value alone.
  static List<String> itemsOf(FactEntry entry) => (entry.value ?? '')
      .split(_separator)
      .map((item) => item.trim())
      .where((item) => item.isNotEmpty)
      .toList();
}
