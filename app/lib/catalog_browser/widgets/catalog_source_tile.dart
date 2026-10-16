import 'package:clinical_brief/catalog_browser/widgets/catalog_json_block.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';

/// The A2UI a preview was drawn from, folded away until asked for.
class const CatalogSourceTile({
  super.key,

  /// The components the preview's surface was sent.
  required final List<JsonMap> components,
}) extends StatelessWidget {
  /// Creates the tile.
  this;

  @override
  Widget build(BuildContext context) => ExpansionTile(
    title: Text(
      'The A2UI that drew it',
      style: Theme.of(context).textTheme.titleSmall,
    ),
    controlAffinity: .leading,
    tilePadding: .zero,
    childrenPadding: const EdgeInsets.only(bottom: AppSpacing.sm),
    // The default centres children, floating narrow content mid-card.
    expandedAlignment: .topLeft,
    expandedCrossAxisAlignment: .stretch,
    children: [CatalogJsonBlock(json: components)],
  );
}
