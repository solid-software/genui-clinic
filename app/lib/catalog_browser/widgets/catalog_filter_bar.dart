import 'package:clinical_brief/catalog_browser/state/catalog_browser_controller.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_origin_tabs.dart';
import 'package:clinical_brief/common/widgets/app_text_field.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The search field and the origin tabs, on one line while they fit.
class const CatalogFilterBar({
  super.key,

  /// The components, the search and the origin shown.
  required final CatalogBrowserController controller,

  /// Holds the search text, so it outlives the field when the page
  /// rebuilds it.
  required final TextEditingController search,
}) extends StatelessWidget {
  static const _searchMaxWidth = 480.0;

  /// Creates the bar.
  this;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: AppSpacing.md,
    runSpacing: AppSpacing.md,
    alignment: .spaceBetween,
    crossAxisAlignment: .center,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _searchMaxWidth),
        child: AppTextField.search(
          controller: search,
          hintText: 'Filter components',
          onChanged: controller.search,
        ),
      ),
      CatalogOriginTabs(
        selected: controller.origin,
        countOf: controller.countOf,
        onSelected: controller.filter,
      ),
    ],
  );
}
