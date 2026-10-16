import 'package:genui/genui.dart';

/// Whether a surface has something to draw yet; a created surface may still
/// lack the `root` GenUI needs, or never get one from a malformed reply.
extension SurfaceReadiness on SurfaceDefinition {
  /// The component id GenUI starts rendering from.
  static const String _rootComponentId = 'root';

  /// Whether the surface has its root component.
  bool get isRenderable => components.containsKey(_rootComponentId);
}
