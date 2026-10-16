import 'package:clinical_brief/catalog_browser/enums/catalog_origin.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_origin_tab.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The origin filter: every component, or one origin's, each with a count.
class const CatalogOriginTabs({
  super.key,

  /// The origin shown; every origin when `null`.
  required final CatalogOrigin? selected,

  /// How many components an origin has; all of them for `null`.
  required final int Function(CatalogOrigin? origin) countOf,

  /// Called with the origin tapped; `null` for every origin.
  required final ValueChanged<CatalogOrigin?> onSelected,
}) extends StatelessWidget {
  /// Creates the tabs.
  this;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
    ),
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xs),
      child: Row(
        mainAxisSize: .min,
        spacing: AppSpacing.xs,
        children: [
          for (final origin in [null, ...CatalogOrigin.values])
            CatalogOriginTab(
              label: origin?.label ?? 'All',
              count: countOf(origin),
              selected: origin == selected,
              onTap: () => onSelected(origin),
            ),
        ],
      ),
    ),
  );
}
