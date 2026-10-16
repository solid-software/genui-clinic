import 'package:clinical_brief/common/widgets/icon_tile.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// The header row of a panel: icon tile, title, subtitle and an end widget.
class const PanelHeader({
  super.key,

  /// The heading.
  required final String title,

  /// Heading and icon colour.
  required final Color accent,

  /// Fill of the icon tile.
  required final Color iconFill,

  /// Optional line under the heading.
  final String? subtitle,

  /// Optional icon in a tile before the heading.
  final IconData? icon,

  /// Optional widget at the end of the row.
  final Widget? trailing,
}) extends StatelessWidget {
  static const double _lineGap = 2.0;

  /// Creates the header.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PanelHeader(:icon, :subtitle, :trailing) = this;

    return Row(
      spacing: AppSpacing.md,
      children: [
        if (icon != null) ...[
          IconTile(icon: icon, color: iconFill, foreground: accent),
          const SizedBox(width: AppSpacing.xs),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: _lineGap,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(color: accent),
              ),
              if (subtitle != null)
                Text(subtitle, style: theme.mutedBodyMedium),
            ],
          ),
        ),
        if (trailing != null)
          // Flexible: a model's annotation can outgrow the room left to it.
          Flexible(child: trailing),
      ],
    );
  }
}
