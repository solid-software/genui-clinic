import 'package:clinical_brief/catalog_browser/models/catalog_entry.dart';
import 'package:clinical_brief/catalog_browser/services/catalog_previews.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_entry_heading.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_preview_actions.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_property_row.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_source_tile.dart';
import 'package:clinical_brief/common/widgets/divided_column.dart';
import 'package:clinical_brief/common/widgets/section_label.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';

/// A component opened in full: its parameters, its live preview, the A2UI
/// that drew it, what it is for and its properties.
class const CatalogEntryDetails({
  super.key,

  /// The component.
  required final CatalogEntry entry,

  /// The surfaces drawing the components, and the A2UI each was sent.
  required final CatalogPreviews previews,

  /// Called when the close button is pressed.
  required final VoidCallback onClose,
}) extends StatefulWidget {
  /// Creates the details.
  this;

  @override
  State<CatalogEntryDetails> createState() => _CatalogEntryDetailsState();
}

class _CatalogEntryDetailsState extends State<CatalogEntryDetails>
    with AutomaticKeepAliveClientMixin<CatalogEntryDetails> {
  static const _revealDuration = Duration(milliseconds: 300);

  /// Kept alive: the lazy list would dispose it once scrolled past, and
  /// built again it would scroll itself back into view.
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // The component open before closes, which can move this one out of view.
    WidgetsBinding.instance.addPostFrameCallback((_) => _reveal());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final entry = widget.entry;

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            CatalogEntryHeading(entry: entry, onClose: widget.onClose),
            const SizedBox(height: AppSpacing.lg),
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(AppSpacing.tileRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Surface(
                  surfaceContext: widget.previews.surfaceOf(entry.name),
                  actionDelegate: const CatalogPreviewActions(),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            CatalogSourceTile(
              components: widget.previews.componentsOf(entry.name),
            ),
            if (entry.description.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Text(entry.description, style: theme.textTheme.bodyLarge),
            ],
            if (entry.properties.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xl),
              const SectionLabel.overline('Properties'),
              DividedColumn(
                crossAxisAlignment: .stretch,
                children: [
                  for (final property in entry.properties)
                    CatalogPropertyRow(property: property),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _reveal() {
    if (!mounted) return;

    Scrollable.ensureVisible(
      context,
      duration: _revealDuration,
      curve: Curves.easeOutCubic,
    );
  }
}
