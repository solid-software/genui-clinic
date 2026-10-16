import 'package:flutter/material.dart';

/// Sections one under another, each as wide as the column.
class const SectionStack({
  super.key,

  /// The sections, top to bottom.
  required final List<Widget> children,
}) extends StatelessWidget {
  /// Creates the stack.
  this;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: children,
  );
}
