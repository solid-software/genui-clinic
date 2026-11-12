import 'package:a2ui_core/a2ui_core.dart';
import 'package:flutter/material.dart';

/// Answers a preview's action with a note: on the catalog page there is no
/// brief agent to send it to.
abstract final class CatalogPreviewActions {
  /// Shows the note for [action] in a snack bar.
  static void show(BuildContext context, A2uiRendererAction action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('In a brief, "${action.name}" goes to the brief agent'),
      ),
    );
  }
}
