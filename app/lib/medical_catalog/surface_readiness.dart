import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';

/// Whether a surface has something to draw yet; a created surface may still
/// lack the root component A2UI needs, or never get one from a malformed
/// reply.
extension SurfaceReadiness on SurfaceModel<ComponentImplementation> {
  /// Whether the surface has its root component.
  bool get isRenderable => componentsModel.has(rootId);
}
