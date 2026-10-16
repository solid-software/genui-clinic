import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// A rounded label: an appointment detail, a count, a status.
class PillChip extends StatelessWidget {
  static const double _iconSize = 16.0;
  static const double _verticalPadding = 7.0;
  static const double _badgeRadius = 20.0;

  /// The text on the pill.
  final String label;

  /// Fill; the theme's tint when `null`.
  final Color? color;

  /// Text and icon colour; the theme's text colour when `null`.
  final Color? foreground;

  /// Optional icon before the label.
  final IconData? icon;

  /// A bolder, roomier pill for the most important detail on a card.
  final bool prominent;

  final bool _isBadge;

  /// Creates a pill.
  const PillChip({
    super.key,
    required this.label,
    this.color,
    this.foreground,
    this.icon,
    this.prominent = false,
  }) : _isBadge = false;

  /// A slim pill in label type, e.g. a count of flagged results.
  const PillChip.badge({
    super.key,
    required this.label,
    required Color this.color,
    required Color this.foreground,
  }) : icon = null,
       prominent = false,
       _isBadge = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color textColor = foreground ?? theme.colorScheme.onSurface;
    final IconData? leading = icon;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(
          _isBadge ? _badgeRadius : AppSpacing.pillRadius,
        ),
      ),
      child: Padding(
        padding: _padding(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (leading != null) ...<Widget>[
              Icon(leading, size: _iconSize, color: textColor),
              const SizedBox(width: AppSpacing.xs),
            ],
            Flexible(
              child: Text(label, style: _labelStyle(theme, textColor)),
            ),
          ],
        ),
      ),
    );
  }

  /// Roomier around a prominent label, slimmer around a badge's.
  EdgeInsets _padding() => EdgeInsets.symmetric(
    horizontal: prominent ? AppSpacing.lg : AppSpacing.md,
    vertical: _isBadge
        ? AppSpacing.xs
        : prominent
        ? AppSpacing.sm
        : _verticalPadding,
  );

  TextStyle? _labelStyle(ThemeData theme, Color color) => _isBadge
      ? theme.textTheme.labelLarge?.copyWith(color: color)
      : (prominent ? theme.textTheme.bodyLarge : theme.textTheme.bodyMedium)
            ?.copyWith(color: color, fontWeight: FontWeight.w500);
}
