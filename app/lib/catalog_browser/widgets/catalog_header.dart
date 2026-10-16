import 'dart:async';

import 'package:clinical_brief/catalog_browser/widgets/catalog_json_dialog.dart';
import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';

/// The page's title, what the page shows, and the catalog's id and JSON.
class const CatalogHeader({
  super.key,

  /// The id the catalog is registered under.
  required final String catalogId,

  /// The catalog's JSON, as the brief agent is told of it.
  required final JsonMap json,
}) extends StatelessWidget {
  static const _introMaxWidth = 640.0;

  /// Creates the header.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text('The catalog', style: theme.textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.sm),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _introMaxWidth),
          child: Text(
            'Every component the brief agent can build a brief from, drawn '
            'live from its own example. Each signature is written as the '
            "agent's prompt lists it, so this is what the model reads.",
            style: theme.mutedBodyMedium,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          crossAxisAlignment: .center,
          children: [
            PillChip(
              label: catalogId,
              icon: Icons.tag,
              color: theme.colorScheme.surface,
            ),
            TextButton.icon(
              onPressed: () => unawaited(CatalogJsonDialog.show(context, json)),
              icon: const Icon(Icons.data_object),
              label: const Text('Raw JSON'),
            ),
          ],
        ),
      ],
    );
  }
}
