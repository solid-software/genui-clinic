import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// A "New" tag sitting on the top edge of a card that just arrived.
class const NewTag({
  super.key,

  /// How visible the tag is, from 0 (hidden) to 1.
  required final double visibility,

  /// The card the tag sits on.
  required final Widget? child,
}) extends StatelessWidget {
  static const double _tagLift = -10.0;
  static const double _tagRadius = 10.0;
  static const double _tagPaddingVertical = 2.0;

  /// Creates the tag.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      // Keeps the section as wide as it would be without the tag.
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: <Widget>[
        child ?? const SizedBox.shrink(),
        if (visibility > 0)
          Positioned(
            top: _tagLift,
            left: AppSpacing.lg,
            child: Opacity(
              opacity: visibility,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(_tagRadius),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: _tagPaddingVertical,
                  ),
                  child: Text(
                    'New',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
