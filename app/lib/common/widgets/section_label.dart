import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// A small muted heading over a group of entries.
class SectionLabel extends StatelessWidget {
  static const _overlineLetterSpacing = 1.0;

  /// The heading, as written.
  final String text;

  /// Space around the heading.
  final EdgeInsetsGeometry padding;

  final bool _isOverline;

  /// Small muted text, as over the sidebar's groups.
  const SectionLabel.group(this.text, {super.key})
    : padding = const EdgeInsets.only(
        left: AppSpacing.sm,
        bottom: AppSpacing.sm,
      ),
      _isOverline = false;

  /// Spaced capitals, as between the blocks of the record.
  const SectionLabel.overline(this.text, {super.key})
    : padding = const EdgeInsets.only(
        top: AppSpacing.sm,
        bottom: AppSpacing.md,
      ),
      _isOverline = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding,
      child: Text(
        _isOverline ? text.toUpperCase() : text,
        style: _isOverline
            ? theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                letterSpacing: _overlineLetterSpacing,
              )
            : theme.mutedBodySmall,
      ),
    );
  }
}
