import 'package:clinical_brief/catalog_browser/models/catalog_entry.dart';
import 'package:clinical_brief/catalog_browser/services/catalog_previews.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_card.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// One row of the grid: cards of equal width, and space where the row has
/// fewer cards than columns.
class const CatalogCardRow({
  super.key,

  /// The components in the row.
  required final List<CatalogEntry> entries,

  /// How many cards a full row holds.
  required final int columns,

  /// The surfaces drawing the components.
  required final CatalogPreviews previews,

  /// Called with the component tapped.
  required final ValueChanged<CatalogEntry> onOpen,
}) extends StatelessWidget {
  /// Creates the row.
  this;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: .start,
    spacing: AppSpacing.cardGap,
    children: [
      for (final entry in entries)
        Expanded(
          child: CatalogCard(
            entry: entry,
            surface: previews.surfaceOf(entry.name),
            onOpen: () => onOpen(entry),
          ),
        ),
      for (var gap = entries.length; gap < columns; gap++) const Spacer(),
    ],
  );
}
