import 'package:clinical_brief/medical_catalog/motion/motion_track.dart';
import 'package:clinical_brief/medical_catalog/motion/render_motion.dart';
import 'package:flutter/widgets.dart';

/// Draws its child where the transition puts it.
class const MotionPaint({
  required super.child,
  super.key,

  /// The transition drawn.
  required final MotionTrack track,
}) extends SingleChildRenderObjectWidget {
  /// Creates the widget.
  this;

  @override
  RenderMotion createRenderObject(BuildContext context) => RenderMotion(track);

  @override
  void updateRenderObject(BuildContext context, RenderMotion renderObject) {
    renderObject.track = track;
  }
}
