import 'dart:math' as math;

import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// A list whose content stays in a centred column of at most [maxWidth],
/// while the whole width still scrolls.
class const CenteredListView({
  super.key,

  /// The items, top to bottom.
  required final List<Widget> children,

  /// Widest the column grows.
  required final double maxWidth,
}) extends StatelessWidget {
  static const double _roomyMinWidth = 640.0;

  /// Creates the list.
  this;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (_, constraints) {
      final gutter = constraints.maxWidth >= _roomyMinWidth
          ? AppSpacing.xxl
          : AppSpacing.lg;
      final side = math.max(
        gutter,
        (constraints.maxWidth - maxWidth) / 2,
      );

      return ListView(
        padding: EdgeInsets.fromLTRB(side, gutter, side, gutter),
        children: children,
      );
    },
  );
}
