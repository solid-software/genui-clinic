import 'package:flutter/material.dart';

/// A glossy lavender sphere, the decoration on the hero cards.
///
/// Drawn with gradients only, so it costs nothing to load and scales freely.
class const GradientOrb({
  super.key,

  /// Diameter of the sphere.
  required final double size,
}) extends StatelessWidget {
  static const Alignment _highlight = Alignment(-0.35, -0.45);
  static const double _gradientRadius = 0.95;
  static const List<Color> _colors = <Color>[
    Color(0xFFFFF5F9),
    Color(0xFFF4C9E2),
    Color(0xFFC9B6F6),
    Color(0xFFA48DF2),
  ];
  static const List<double> _stops = <double>[0.0, 0.32, 0.7, 1.0];
  static const Color _glow = Color(0x40A48DF2);
  static const double _glowBlurShare = 0.3;
  static const double _glowDropShare = 0.12;

  /// Creates an orb.
  this;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            center: _highlight,
            radius: _gradientRadius,
            colors: _colors,
            stops: _stops,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _glow,
              blurRadius: size * _glowBlurShare,
              offset: Offset(0.0, size * _glowDropShare),
            ),
          ],
        ),
      ),
    ),
  );
}
