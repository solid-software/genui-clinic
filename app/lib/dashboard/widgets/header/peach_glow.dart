import 'package:clinical_brief/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// A soft peach light rising from the bottom of the hero.
class const PeachGlow({super.key}) extends StatelessWidget {
  static const _height = 180.0;
  static const _centre = Alignment(-0.1, 1.2);
  static const _spread = 1.1;
  static const _colors = <Color>[
    AppTheme.peachGlowStart,
    AppTheme.peachGlowEnd,
  ];

  /// Creates a soft peach light rising from the bottom of the hero
  this;

  @override
  Widget build(BuildContext context) => const SizedBox(
    height: _height,
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: _centre,
          radius: _spread,
          colors: _colors,
        ),
      ),
    ),
  );
}
