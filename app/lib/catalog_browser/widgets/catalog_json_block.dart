import 'dart:convert';

import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// JSON, indented, on a tinted tile; selectable, to copy.
class const CatalogJsonBlock({
  super.key,

  /// The value shown, e.g. a list of A2UI components.
  required final Object? json,
}) extends StatelessWidget {
  static const _encoder = JsonEncoder.withIndent('  ');

  /// Creates the block.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.tileRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SelectableText(
          _encoder.convert(json),
          style: theme.textTheme.bodySmall,
        ),
      ),
    );
  }
}
