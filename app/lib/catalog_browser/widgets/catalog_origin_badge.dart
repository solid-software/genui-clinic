import 'package:clinical_brief/catalog_browser/enums/catalog_origin.dart';
import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:flutter/material.dart';

/// Marks a component this app draws; a basic one goes unmarked.
class const CatalogOriginBadge({
  super.key,

  /// Where the component comes from.
  required final CatalogOrigin origin,
}) extends StatelessWidget {
  /// Creates the badge.
  this;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return switch (origin) {
      .medical => PillChip.badge(
        label: origin.label,
        color: colors.primaryContainer,
        foreground: colors.onPrimaryContainer,
      ),
      .basic => const SizedBox.shrink(),
    };
  }
}
