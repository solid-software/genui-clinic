import 'dart:async';

import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A demo prompt on a rounded tile: tapped to use it, or to copy it.
class PromptTile extends StatelessWidget {
  static const _copyIconSize = 18.0;

  /// The prompt.
  final String text;

  /// Called with [text] when the tile is tapped; `null` copies it instead.
  final ValueChanged<String>? onUse;

  /// A white tile with a "Use" pill that hands [text] to [onUse].
  const PromptTile.use({
    super.key,
    required this.text,
    required ValueChanged<String> this.onUse,
  });

  /// A tinted tile with a copy icon that puts [text] on the clipboard.
  const PromptTile.copy({super.key, required this.text}) : onUse = null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final corners = BorderRadius.circular(AppSpacing.tileRadius);
    final onUse = this.onUse;

    return Material(
      color: onUse == null ? colors.surfaceContainerHighest : colors.surface,
      borderRadius: corners,
      child: InkWell(
        borderRadius: corners,
        onTap: () => onUse == null ? unawaited(_copy(context)) : onUse(text),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            crossAxisAlignment: onUse == null ? .start : .center,
            children: [
              Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
              if (onUse == null) ...[
                const SizedBox(width: AppSpacing.sm),
                Icon(Icons.copy, size: _copyIconSize, color: colors.primary),
              ] else ...[
                const SizedBox(width: AppSpacing.md),
                PillChip(
                  label: 'Use',
                  color: colors.primaryContainer,
                  foreground: colors.onPrimaryContainer,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copy(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: text));
    messenger.showSnackBar(const SnackBar(content: Text('Copied')));
  }
}
