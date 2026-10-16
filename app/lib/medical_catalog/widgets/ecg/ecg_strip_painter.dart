import 'dart:math' as math;

import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Draws paper grid, then one beat per cycle across the strip.
class const EcgStripPainter({
  /// Beats per minute the trace is drawn at.
  required final int rate,

  /// Whether the beats are unevenly spaced.
  required final bool irregular,

  /// Colour of the trace.
  required final Color traceColor,

  /// Colour of the paper grid.
  required final Color gridColor,
}) extends CustomPainter {
  static const _gridStep = 12.0;
  static const _traceWidth = 2.0;
  static const _gridWidth = 0.5;
  static const _beatsPerScreen = 6.0;

  /// How much the length of a beat varies when the rhythm is irregular.
  static const _irregularSpread = 0.36;
  static const _samplesPerBeat = 60;

  /// Rate at which [_beatsPerScreen] beats fill the strip.
  static const _restingRate = 72.0;

  /// The slowest and fastest rates the strip will draw.
  static const _minRate = 20;
  static const _maxRate = 250;

  /// Factor for the middle of the strip, and the middle of a jitter range.
  static const _centreFactor = 0.5;

  /// One beat as (phase, height fraction) points: P wave, QRS, then T wave.
  static const List<(double, double)> _beatShape = [
    (0.0, 0.0),
    (0.06, 0.12),
    (0.12, 0.0),
    (0.16, -0.12),
    (0.2, 0.0),
    (0.26, 1.0),
    (0.32, -0.35),
    (0.38, 0.0),
    (0.5, 0.3),
    (0.62, 0.0),
    (1.0, 0.0),
  ];

  /// Creates the painter.
  this;

  @override
  void paint(Canvas canvas, Size size) {
    _paintGrid(canvas, size);
    _paintTrace(canvas, size);
  }

  @override
  bool shouldRepaint(EcgStripPainter oldDelegate) =>
      oldDelegate.rate != rate ||
      oldDelegate.irregular != irregular ||
      oldDelegate.traceColor != traceColor;

  void _paintGrid(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = gridColor
      ..strokeWidth = _gridWidth;
    for (double x = 0; x < size.width; x += _gridStep) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += _gridStep) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  void _paintTrace(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = traceColor
      ..strokeWidth = _traceWidth
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    final double baseline = size.height * _centreFactor;
    final double amplitude = size.height * _centreFactor - AppSpacing.sm;
    // Clamped: a zero or negative rate would never advance along the strip.
    final double beats =
        _beatsPerScreen * (rate.clamp(_minRate, _maxRate) / _restingRate);
    final double beatWidth = size.width / beats;
    final math.Random jitter = math.Random(rate);

    final Path path = Path()..moveTo(0, baseline);
    double x = 0;
    while (x < size.width) {
      final double width = irregular
          ? beatWidth * _jitterFactor(jitter)
          : beatWidth;
      for (int sample = 0; sample <= _samplesPerBeat; sample++) {
        final double phase = sample / _samplesPerBeat;
        path.lineTo(x + width * phase, baseline - amplitude * _beat(phase));
      }
      x += width;
    }

    canvas.drawPath(path, paint);
  }

  /// How much longer or shorter than average the next beat runs.
  double _jitterFactor(math.Random jitter) =>
      1 + (jitter.nextDouble() - _centreFactor) * _irregularSpread;

  /// Trace height at [phase] through a beat, interpolated from [_beatShape].
  double _beat(double phase) {
    for (int index = 1; index < _beatShape.length; index++) {
      final (double end, double endHeight) = _beatShape[index];
      if (phase > end) {
        continue;
      }
      final (double start, double startHeight) = _beatShape[index - 1];
      final double span = end - start;
      final double fraction = span == 0 ? 0 : (phase - start) / span;

      return startHeight + (endHeight - startHeight) * fraction;
    }

    return 0;
  }
}
