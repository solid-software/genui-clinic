import 'package:clinical_brief/demo/widgets/prompt_tile.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// A labelled prompt that copies itself to the clipboard when tapped.
class const CopyablePrompt({
  super.key,

  /// What to do with the prompt.
  required final String label,

  /// The prompt.
  required final String text,
}) extends StatelessWidget {
  /// Creates the prompt.
  this;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.lg),
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        PromptTile.copy(text: text),
      ],
    ),
  );
}
