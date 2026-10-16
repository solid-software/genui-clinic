import 'package:flutter/material.dart';

/// A column with a divider between its children, and optionally one above
/// the first.
class const DividedColumn({
  super.key,

  /// The rows, top to bottom.
  required final List<Widget> children,

  /// Colour of the dividers; the theme's when `null`.
  final Color? dividerColor,

  /// Space each divider takes; the theme's when `null`.
  final double? dividerHeight,

  /// Whether a divider also runs above the first row.
  final bool hasLeadingDivider = false,

  /// How the rows are aligned across the column.
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
}) extends StatelessWidget {
  /// Creates the column.
  this;

  @override
  Widget build(BuildContext context) {
    final Widget divider = Divider(height: dividerHeight, color: dividerColor);

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: <Widget>[
        if (hasLeadingDivider) divider,
        for (int index = 0; index < children.length; index++) ...<Widget>[
          if (index > 0) divider,
          children[index],
        ],
      ],
    );
  }
}
