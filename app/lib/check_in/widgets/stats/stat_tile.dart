import 'package:clinical_brief/common/widgets/icon_tile.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// One coloured tile: icon, a big number with its label, and a caption.
class const StatTile({
  super.key,

  /// The icon in the tile's corner.
  required final IconData icon,

  /// The big number, e.g. `3` or `10:40`.
  required final String value,

  /// What the number counts, beside it.
  required final String label,

  /// One line of context under the number.
  required final String caption,

  /// Fill of the tile.
  required final Color color,

  /// Fill of the icon's square; white when `null`.
  final Color? iconColor,

  /// Colour of the icon; the theme's text colour when `null`.
  final Color? iconForeground,
}) extends StatelessWidget {
  static const _numberLabelGap = 10.0;
  static const _captionOpacity = 0.7;

  /// Creates a tile.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          IconTile(
            icon: icon,
            color: iconColor ?? theme.colorScheme.surface,
            foreground: iconForeground,
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            crossAxisAlignment: .baseline,
            textBaseline: .alphabetic,
            children: [
              Text(
                value,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: .w400,
                ),
              ),
              const SizedBox(width: _numberLabelGap),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: .w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            caption,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(
                alpha: _captionOpacity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
