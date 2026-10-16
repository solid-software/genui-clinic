import 'package:clinical_brief/catalog_browser/models/catalog_function_entry.dart';
import 'package:clinical_brief/common/widgets/divided_column.dart';
import 'package:clinical_brief/common/widgets/panel_card.dart';
import 'package:clinical_brief/common/widgets/section_label.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// The functions the components can call, each with what it does.
class const CatalogFunctionsSection({
  super.key,

  /// The functions.
  required final List<CatalogFunctionEntry> functions,
}) extends StatelessWidget {
  /// Creates the section.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionLabel.overline('Functions'),
        PanelCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.sm,
          ),
          child: DividedColumn(
            crossAxisAlignment: .stretch,
            children: [
              for (final function in functions)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: AppSpacing.xs,
                    children: [
                      Text(
                        function.signature,
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(function.description, style: theme.mutedBodyMedium),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
