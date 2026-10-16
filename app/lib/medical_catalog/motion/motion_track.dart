import 'dart:math' as math;

import 'package:clinical_brief/medical_catalog/motion/motion_change.dart';
import 'package:clinical_brief/medical_catalog/motion/motion_frame.dart';
import 'package:flutter/widgets.dart';

/// One section's transition, shared by its state and its render object.
class MotionTrack {
  static const double _riseDistance = 48.0;
  static const double _enterScale = 0.92;

  /// How much larger a section is at the top of its lift.
  static const double _liftScale = 0.025;
  static const double _keptLiftShare = 0.6;

  /// The whole transition, which the render object repaints on.
  final Animation<double> progress;

  /// The movement, eased.
  final Animation<double> move;

  /// How visible a new section is.
  final Animation<double> fade;

  /// Finds the section's old place, the first time it is painted.
  final ValueSetter<RenderBox> onFirstPaint;

  /// Where the section starts, relative to its new place.
  Offset from = Offset.zero;

  /// What the section does in this transition.
  MotionChange change = MotionChange.none;

  /// Whether the section's old place still has to be looked up.
  bool pending = false;

  /// Where and how the section is drawn right now.
  MotionFrame get frame {
    final double t = move.value;
    final double arc = math.sin(t * math.pi);

    return switch (change) {
      MotionChange.none => MotionFrame.still,
      MotionChange.moved => MotionFrame(
        offset: from * (1 - t),
        scale: 1 + _liftScale * arc,
        opacity: 1,
        lift: arc,
      ),
      MotionChange.kept => MotionFrame(
        offset: Offset.zero,
        scale: 1 + _liftScale * _keptLiftShare * arc,
        opacity: 1,
        lift: _keptLiftShare * arc,
      ),
      MotionChange.entered => MotionFrame(
        offset: Offset(0, _riseDistance * (1 - t)),
        scale: _enterScale + (1 - _enterScale) * t,
        opacity: fade.value,
        lift: 0,
      ),
    };
  }

  /// Creates a track over the card's animations.
  MotionTrack({
    required this.progress,
    required this.move,
    required this.fade,
    required this.onFirstPaint,
  });

  /// Measures at first paint: after layout, so the new place is known, and
  /// before display, so the section is first seen at its old place.
  void measureIfPending(RenderBox box) {
    if (!pending) {
      return;
    }
    pending = false;
    onFirstPaint(box);
  }
}
