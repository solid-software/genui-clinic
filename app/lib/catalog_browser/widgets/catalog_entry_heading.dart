import 'package:clinical_brief/catalog_browser/models/catalog_entry.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_origin_badge.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// An open component's name, origin and parameters, and a close button.
class const CatalogEntryHeading({
  super.key,

  /// The component.
  required final CatalogEntry entry,

  /// Called when the close button is pressed.
  required final VoidCallback onClose,
}) extends StatelessWidget {
  /// Creates the heading.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: .start,
      spacing: AppSpacing.md,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: AppSpacing.xs,
            children: [
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.xs,
                crossAxisAlignment: .center,
                children: [
                  Text(entry.name, style: theme.textTheme.headlineSmall),
                  CatalogOriginBadge(origin: entry.origin),
                ],
              ),
              Text(entry.parameterList, style: theme.mutedBodyMedium),
            ],
          ),
        ),
        IconButton(
          onPressed: onClose,
          tooltip: 'Close',
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
