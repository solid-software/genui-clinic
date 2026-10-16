import 'package:flutter/rendering.dart';

/// Where and how a section is drawn at one moment of its transition.
class MotionFrame {
  /// The section drawn as if it were not moving.
  static const MotionFrame still = MotionFrame(
    offset: Offset.zero,
    scale: 1,
    opacity: 1,
    lift: 0,
  );

  /// Factor for the centre of the section, which it scales around.
  static const double _centre = 0.5;

  /// How far the section is from its place.
  final Offset offset;

  /// How large the section is drawn; 1 is its own size.
  final double scale;

  /// How visible the section is.
  final double opacity;

  /// How high the section is lifted, from 0 to 1; its shadow follows.
  final double lift;

  /// Whether the section is drawn as if it were not moving at all.
  bool get isStill =>
      offset == Offset.zero && scale == 1 && opacity == 1 && lift == 0;

  /// Creates a frame.
  const MotionFrame({
    required this.offset,
    required this.scale,
    required this.opacity,
    required this.lift,
  });

  /// Moves the section by [offset] and scales it about its centre.
  Matrix4 transformFor(Size size) {
    final double dx = offset.dx + size.width * _centre * (1 - scale);
    final double dy = offset.dy + size.height * _centre * (1 - scale);

    // Column by column: a uniform scale, then the translation.
    return Matrix4(scale, 0, 0, 0, 0, scale, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
  }
}
