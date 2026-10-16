import 'package:clinical_brief/common/models/shell_section.dart';
import 'package:clinical_brief/common/widgets/shell/shell_narrow_frame.dart';
import 'package:clinical_brief/common/widgets/shell/shell_wide_frame.dart';
import 'package:clinical_brief/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// The frame every screen sits in.
///
/// Wide: a rounded window on a soft gradient, sidebar on the left. Narrow:
/// the brand above the content and the footer under it.
class const AppShell({
  super.key,

  /// The section the screen belongs to, highlighted in the sidebar.
  required final ShellSection section,

  /// The screen's content; it scrolls on its own.
  required final Widget child,

  /// Who the brief is for, shown in the sidebar.
  final String? briefLabel,

  /// Optional note at the bottom of the sidebar, or under narrow content.
  final Widget? footer,
}) extends StatefulWidget {
  /// Creates the shell.
  this;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  static const _wideMinWidth = 1000.0;
  static const _backdrop = <Color>[
    AppTheme.backdropStart,
    AppTheme.backdropMiddle,
    AppTheme.backdropEnd,
  ];

  /// Keeps the content's state, scroll position and typed text included,
  /// when a resize or rotation swaps one frame for the other.
  final _content = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final content = KeyedSubtree(key: _content, child: widget.child);

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: .topLeft,
            end: .bottomRight,
            colors: _backdrop,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (_, constraints) => constraints.maxWidth >= _wideMinWidth
                ? ShellWideFrame(
                    section: widget.section,
                    briefLabel: widget.briefLabel,
                    footer: widget.footer,
                    child: content,
                  )
                : ShellNarrowFrame(footer: widget.footer, child: content),
          ),
        ),
      ),
    );
  }
}
