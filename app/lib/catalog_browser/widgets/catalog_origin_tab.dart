import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// One tab of the origin filter: a name and its count, lavender when it is
/// the one shown.
class const CatalogOriginTab({
  super.key,

  /// The tab's name, e.g. `Medical`.
  required final String label,

  /// How many components the tab shows.
  required final int count,

  /// Whether the tab is the one shown.
  required final bool selected,

  /// Called when the tab is tapped.
  required final VoidCallback onTap,
}) extends StatelessWidget {
  /// Creates the tab.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final corners = BorderRadius.circular(AppSpacing.pillRadius);
    final style = theme.textTheme.labelLarge?.copyWith(
      color: selected ? colors.onPrimaryContainer : colors.onSurface,
    );

    return Semantics(
      selected: selected,
      child: Material(
        color: selected ? colors.primaryContainer : Colors.transparent,
        borderRadius: corners,
        child: InkWell(
          borderRadius: corners,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisSize: .min,
              spacing: AppSpacing.sm,
              children: [
                Text(label, style: style),
                Text(
                  '$count',
                  style: style?.copyWith(
                    fontWeight: .w400,
                    color: selected ? null : colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
