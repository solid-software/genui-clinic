import 'package:clinical_brief/common/models/shell_section.dart';
import 'package:clinical_brief/common/widgets/shell/app_sidebar.dart';
import 'package:flutter/material.dart';

/// The rounded window with the sidebar, for desktop widths.
class const ShellWideFrame({
  super.key,

  /// The section highlighted in the sidebar.
  required final ShellSection section,

  /// The screen's content.
  required final Widget child,

  /// Who the brief is for, shown in the sidebar.
  final String? briefLabel,

  /// Optional note at the bottom of the sidebar.
  final Widget? footer,
}) extends StatelessWidget {
  static const _inset = 16.0;
  static const _radius = 32.0;
  static const _shadow = Color(0x1A3B2C86);
  static const _shadowBlur = 48.0;
  static const _shadowOffset = Offset(0.0, 16.0);

  /// Creates shell wide frame
  this;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(_radius);

    return Padding(
      padding: const EdgeInsets.all(_inset),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: borderRadius,
          boxShadow: const [
            BoxShadow(
              color: _shadow,
              blurRadius: _shadowBlur,
              offset: _shadowOffset,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Row(
            crossAxisAlignment: .stretch,
            children: [
              AppSidebar(
                section: section,
                briefLabel: briefLabel,
                footer: footer,
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
