import 'package:flutter/material.dart';

/// The round marker of one study on an imaging timeline.
class const TimelineDot({
  super.key,

  /// Fill of the dot.
  required final Color color,
}) extends StatelessWidget {
  static const double _size = 11.0;

  /// Creates a dot.
  this;

  @override
  Widget build(BuildContext context) => Container(
    width: _size,
    height: _size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}
