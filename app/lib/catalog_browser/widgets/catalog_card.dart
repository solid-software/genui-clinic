import 'package:clinical_brief/catalog_browser/models/catalog_entry.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_origin_badge.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_thumbnail.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';

/// A component in the grid: its live preview over its name. A tap opens it.
class const CatalogCard({
  super.key,

  /// The component.
  required final CatalogEntry entry,

  /// The surface drawing it.
  required final SurfaceContext surface,

  /// Called when the card is tapped.
  required final VoidCallback onOpen,
}) extends StatelessWidget {
  /// Creates the card.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final corners = BorderRadius.circular(AppSpacing.cardRadius);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: corners,
      child: InkWell(
        borderRadius: corners,
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: AppSpacing.md,
            children: [
              CatalogThumbnail(surface: surface),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.sm,
                  0.0,
                  AppSpacing.sm,
                  AppSpacing.sm,
                ),
                child: Row(
                  spacing: AppSpacing.sm,
                  children: [
                    Expanded(
                      child: Text(
                        entry.name,
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    CatalogOriginBadge(origin: entry.origin),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
