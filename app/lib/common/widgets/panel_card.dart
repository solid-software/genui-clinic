import 'package:clinical_brief/common/widgets/panel_header.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// A rounded panel with an optional header: icon tile, title, subtitle and
/// something on the right, such as a count.
class const PanelCard({
  super.key,

  /// The body of the panel.
  required final Widget child,

  /// Optional heading, e.g. `Waiting list`.
  final String? title,

  /// Optional line under the heading, e.g. `By slot time`.
  final String? subtitle,

  /// Optional icon in a tile before the heading.
  final IconData? icon,

  /// Optional widget at the end of the header row.
  final Widget? trailing,

  /// Fill; white when `null`.
  final Color? color,

  /// Heading and icon colour; the theme's text colour when `null`.
  final Color? accent,

  /// Space around the content.
  final EdgeInsetsGeometry padding = const EdgeInsets.all(AppSpacing.xl),
}) extends StatelessWidget {
  /// Creates a panel.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color fill = color ?? theme.colorScheme.surface;
    final String? heading = title;

    // Material, not a decorated box, so rows inside can show ink.
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: fill,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (heading != null) ...<Widget>[
                PanelHeader(
                  title: heading,
                  subtitle: subtitle,
                  icon: icon,
                  trailing: trailing,
                  accent: accent ?? theme.colorScheme.onSurface,
                  // A white tile on a tinted panel, a tinted one on white.
                  iconFill: fill == theme.colorScheme.surface
                      ? theme.colorScheme.surfaceContainerHighest
                      : theme.colorScheme.surface,
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }
}
