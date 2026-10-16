import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// One row of a chart grid, charts aligned to the top.
class const ChartRow({
  super.key,

  /// The charts in the row, side by side.
  required final List<Widget> children,
}) extends StatelessWidget {
  /// Creates the row.
  this;

  @override
  Widget build(BuildContext context) {
    if (children.length == 1) {
      return children.first;
    }

    // Not IntrinsicHeight: it leaves LayoutBuilder children unsized, which
    // crashes on the first tap.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.cardGap,
      children: <Widget>[
        for (final Widget chart in children) Expanded(child: chart),
      ],
    );
  }
}
