import 'package:flutter/material.dart';

/// One bar, with the target drawn across it.
class const ComparisonBar({
  super.key,

  /// How much of the track the bar fills, from 0 to 1.
  required final double fraction,

  /// Where the target line sits on the track, or `null` for none.
  required final double? targetFraction,

  /// Colour of the bar.
  required final Color color,
}) extends StatelessWidget {
  static const double _barHeight = 14.0;
  static const double _barRadius = 7.0;
  static const double _targetWidth = 2.0;

  /// Creates a bar.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double? marker = targetFraction;

    return LayoutBuilder(
      builder: (_, constraints) => SizedBox(
        height: _barHeight,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(_barRadius),
              ),
            ),
            FractionallySizedBox(
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(_barRadius),
                ),
              ),
            ),
            if (marker != null)
              Positioned(
                left: constraints.maxWidth * marker.clamp(0.0, 1.0),
                top: 0.0,
                bottom: 0.0,
                child: Container(
                  width: _targetWidth,
                  color: theme.colorScheme.onSurface,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
