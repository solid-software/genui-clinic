import 'package:clinical_brief/catalog_browser/models/catalog_property.dart';
import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// One property: its name, whether it is required or static, and what it
/// is for.
class const CatalogPropertyRow({
  super.key,

  /// The property.
  required final CatalogProperty property,
}) extends StatelessWidget {
  /// Creates the row.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSpacing.xs,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            crossAxisAlignment: .center,
            children: [
              Text(property.name, style: theme.textTheme.titleSmall),
              if (property.isRequired)
                PillChip.badge(
                  label: 'Required',
                  color: ClinicalTone.warning.backgroundOf(context),
                  foreground: ClinicalTone.warning.foregroundOf(context),
                ),
              if (!property.isBindable)
                Tooltip(
                  message: 'Written into the component; not bound to data',
                  child: PillChip.badge(
                    label: 'Static',
                    color: colors.surfaceContainerHighest,
                    foreground: colors.onSurfaceVariant,
                  ),
                ),
            ],
          ),
          if (property.description.isNotEmpty)
            Text(property.description, style: theme.mutedBodyMedium),
        ],
      ),
    );
  }
}
