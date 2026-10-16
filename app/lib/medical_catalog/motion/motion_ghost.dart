import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

/// A picture of a section that left the brief, on its way into the record.
class MotionGhost {
  /// The section's motion key.
  final String key;

  /// The section as it was last drawn.
  final ui.Image picture;

  /// Where the section was on the brief it left.
  final Rect from;

  /// When it sets off, as a share of the whole departure.
  double start = 0;

  /// Creates a ghost.
  MotionGhost({required this.key, required this.picture, required this.from});
}
