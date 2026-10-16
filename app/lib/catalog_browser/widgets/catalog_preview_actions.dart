import 'package:flutter/material.dart';
import 'package:genui/genui.dart';

/// Answers a preview's actions with a note: on the catalog page there is no
/// brief agent to send them to.
final class const CatalogPreviewActions() implements ActionDelegate {
  /// Creates the delegate.
  this;

  @override
  bool handleEvent(
    BuildContext context,
    UiEvent event,
    SurfaceContext genUiContext,
    Widget Function(SurfaceDefinition, Catalog, String, DataContext)
    buildWidget,
  ) {
    if (!event.isUserAction) return false;
    final name = UserActionEvent.fromMap(event.toMap()).name;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('In a brief, “$name” goes to the brief agent'),
      ),
    );

    return true;
  }
}
