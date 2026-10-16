import 'package:flutter/material.dart';

/// A dialog with a title, scrolling content and one button that closes it.
class const AppDialog({
  super.key,

  /// The heading.
  required final String title,

  /// Width of the content.
  required final double width,

  /// The content; it scrolls when taller than the screen allows.
  required final Widget content,

  /// The closing button's label, e.g. `Close`.
  required final String closeLabel,
}) extends StatelessWidget {
  /// Creates the dialog.
  this;

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(title),
    content: SizedBox(
      width: width,
      child: SingleChildScrollView(child: content),
    ),
    actions: [
      TextButton(
        onPressed: Navigator.of(context).pop,
        child: Text(closeLabel),
      ),
    ],
  );
}
