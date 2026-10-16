import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// An icon on a rounded square, the marker at the head of a card.
class const IconTile({
  super.key,

  /// The icon shown.
  required final IconData icon,

  /// Fill; the theme's tint when `null`.
  final Color? color,

  /// Icon colour; the theme's text colour when `null`.
  final Color? foreground,

  /// Width and height of the square.
  final double size = _defaultSize,
}) extends StatelessWidget {
  static const double _defaultSize = 44.0;
  static const double _iconShare = 0.46;

  /// Creates an icon tile.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSpacing.tileRadius),
        ),
        child: Icon(
          icon,
          size: size * _iconShare,
          color: foreground ?? theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
