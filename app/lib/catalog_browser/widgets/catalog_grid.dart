import 'package:clinical_brief/catalog_browser/models/catalog_entry.dart';
import 'package:clinical_brief/catalog_browser/services/catalog_previews.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_card_row.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_entry_details.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// The components as cards in rows. The open one takes a row of its own,
/// the whole width, where it falls; the rows carry on under it.
class const CatalogGrid({
  super.key,

  /// The components shown.
  required final List<CatalogEntry> entries,

  /// The component opened in full, or `null`.
  required final CatalogEntry? openEntry,

  /// The surfaces drawing the components.
  required final CatalogPreviews previews,

  /// Called with the component to open, or to close when it is open.
  required final ValueChanged<CatalogEntry> onToggle,
}) extends StatelessWidget {
  static const _threeColumnMinWidth = 900.0;
  static const _twoColumnMinWidth = 560.0;
  static const _wideColumns = 3;
  static const _mediumColumns = 2;

  /// Creates the grid.
  this;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
        child: Text(
          'No component matches the filter.',
          textAlign: .center,
          style: Theme.of(context).mutedBodyMedium,
        ),
      );
    }
    final openIndex = entries.indexWhere((entry) => entry == openEntry);

    return LayoutBuilder(
      builder: (_, constraints) {
        final columns = constraints.maxWidth >= _threeColumnMinWidth
            ? _wideColumns
            : constraints.maxWidth >= _twoColumnMinWidth
            ? _mediumColumns
            : 1;
        final rows = openIndex < 0
            ? entries.slices(columns)
            : [
                ...entries.take(openIndex).slices(columns),
                [entries[openIndex]],
                ...entries.skip(openIndex + 1).slices(columns),
              ];

        return Column(
          crossAxisAlignment: .stretch,
          spacing: AppSpacing.cardGap,
          children: [
            for (final row in rows)
              if (row case [final entry] when entry == openEntry)
                CatalogEntryDetails(
                  key: ValueKey(entry.name),
                  entry: entry,
                  previews: previews,
                  onClose: () => onToggle(entry),
                )
              else
                CatalogCardRow(
                  entries: row,
                  columns: columns,
                  previews: previews,
                  onOpen: onToggle,
                ),
          ],
        );
      },
    );
  }
}
