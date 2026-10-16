import 'package:clinical_brief/medical_catalog/motion/motion_scope.dart';
import 'package:flutter/widgets.dart';

/// Hands a [MotionScope]'s state to the sections under it.
class const MotionScopeMarker({
  required super.child,
  super.key,

  /// The scope's state.
  required final MotionScopeState state,

  /// The brief on screen; a new one notifies the sections.
  required final Object generation,
}) extends InheritedWidget {
  /// Creates the marker.
  this;

  @override
  bool updateShouldNotify(MotionScopeMarker oldWidget) =>
      oldWidget.generation != generation;
}
