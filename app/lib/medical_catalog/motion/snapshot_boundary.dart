import 'package:clinical_brief/medical_catalog/motion/render_snapshot_boundary.dart';
import 'package:flutter/widgets.dart';

/// A repaint boundary that can hand out a picture of what it last drew.
class const SnapshotBoundary({
  required super.child,
  super.key,
}) extends SingleChildRenderObjectWidget {
  /// Creates the boundary.
  this;

  @override
  RenderSnapshotBoundary createRenderObject(BuildContext context) =>
      RenderSnapshotBoundary();
}
