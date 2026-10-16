import 'package:clinical_brief/catalog_browser/services/catalog_previews.dart';
import 'package:clinical_brief/catalog_browser/state/catalog_browser_controller.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_filter_bar.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_functions_section.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_grid.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_header.dart';
import 'package:clinical_brief/common/widgets/centered_list_view.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The catalog: the header, the filters, the components and the functions.
class const CatalogBody({
  super.key,

  /// The components, the functions, the search and what is open.
  required final CatalogBrowserController controller,

  /// The surfaces drawing the components.
  required final CatalogPreviews previews,

  /// The search text, kept by the screen so it outlives this body.
  required final TextEditingController search,
}) extends StatelessWidget {
  /// Creates the catalog's body.
  this;

  @override
  Widget build(BuildContext context) => CenteredListView(
    maxWidth: AppSpacing.contentMaxWidth,
    children: [
      CatalogHeader(catalogId: controller.catalogId, json: controller.json),
      const SizedBox(height: AppSpacing.xl),
      CatalogFilterBar(controller: controller, search: search),
      const SizedBox(height: AppSpacing.xl),
      CatalogGrid(
        entries: controller.visibleEntries,
        openEntry: controller.openEntry,
        previews: previews,
        onToggle: controller.toggle,
      ),
      const SizedBox(height: AppSpacing.xxl),
      CatalogFunctionsSection(functions: controller.functions),
    ],
  );
}
