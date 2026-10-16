import 'package:clinical_brief/demo/widgets/prompt_tile.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// The short demo guide that sits above a complaint field.
class const DemoPromptPanel({
  super.key,

  /// The line above the prompts.
  required final String intro,

  /// The prompts, in the order they should be tried.
  required final List<String> prompts,

  /// Called with the prompt the presenter picked.
  required final ValueChanged<String> onPick,
}) extends StatelessWidget {
  static const double _iconSize = 18.0;

  /// Creates the panel.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.auto_awesome,
                size: _iconSize,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(intro, style: theme.mutedBodyMedium)),
            ],
          ),
          for (final String prompt in prompts)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: PromptTile.use(text: prompt, onUse: onPick),
            ),
        ],
      ),
    );
  }
}
