import 'dart:math' as math;

import 'package:clinical_brief/common/utils/number_formatting.dart';
import 'package:clinical_brief/medical_catalog/models/trend_point.dart';
import 'package:clinical_brief/medical_catalog/widgets/trends/trend_chart_scale.dart';
import 'package:flutter/material.dart';

/// Draws the sparkline used by `TrendChart`.
class TrendChartPainter extends CustomPainter {
  static const double _topInset = 28.0;
  static const double _bottomInset = 24.0;
  static const double _sideInset = sideInset;

  /// Space left of the first point and right of the last one.
  static const double sideInset = 24.0;
  static const double _dotRadius = 4.0;
  static const double _strokeWidth = 2.4;
  static const double _dashWidth = 4.0;
  static const double _dashGap = 4.0;
  static const double _labelGap = 6.0;
  static const double _rangePadFactor = 0.15;
  static const double _flatRangePad = 1.0;
  static const double _sizeMultiplier = 2;
  static const double _sideInsetTotal = _sideInset * _sizeMultiplier;
  static const double _referenceLabelLift = _labelGap * _sizeMultiplier;
  static const int _minPointsForLine = 2;
  static const double _centreFactor = 0.5;
  static const double _minLabelGap = 10.0;
  static const double _selectedDotScale = 1.8;

  /// Points to plot, oldest first.
  final List<TrendPoint> points;

  /// Colour of the line and dots.
  final Color lineColor;

  /// Colour of the dashed reference line.
  final Color mutedColor;

  /// Style for the value labels above the dots.
  final TextStyle valueStyle;

  /// Style for the axis labels and the reference value.
  final TextStyle axisStyle;

  /// Optional threshold drawn as a dashed line, e.g. lower limit of normal.
  final double? referenceValue;

  /// Whether readings are labelled with their value and date.
  final bool labelPoints;

  /// The reading the doctor tapped, drawn larger.
  final int? selectedIndex;

  /// Creates a painter.
  const TrendChartPainter({
    required this.points,
    required this.lineColor,
    required this.mutedColor,
    required this.valueStyle,
    required this.axisStyle,
    this.referenceValue,
    this.selectedIndex,
    this.labelPoints = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) {
      return;
    }

    final TrendChartScale scale = _scaleFor(size);
    _paintReferenceLine(canvas, size, scale);
    final List<Offset> plotted = <Offset>[
      for (int index = 0; index < points.length; index++)
        Offset(scale.xFor(index), scale.yFor(points[index].value)),
    ];
    _paintLine(canvas, plotted);
    _paintDots(canvas, plotted);
    if (!labelPoints) {
      // Compact charts name their readings in the caption instead.
      return;
    }
    final int stride = _labelStride(size);
    _paintValueLabels(canvas, size, plotted, stride);
    _paintAxisLabels(canvas, size, stride);
  }

  @override
  bool shouldRepaint(TrendChartPainter oldDelegate) =>
      oldDelegate.points != points ||
      oldDelegate.lineColor != lineColor ||
      oldDelegate.referenceValue != referenceValue ||
      oldDelegate.labelPoints != labelPoints ||
      oldDelegate.selectedIndex != selectedIndex;

  TrendChartScale _scaleFor(Size size) {
    final List<double> values = <double>[
      for (final TrendPoint point in points) point.value,
      ?referenceValue,
    ];
    double lowest = values.reduce((a, b) => a < b ? a : b);
    double highest = values.reduce((a, b) => a > b ? a : b);
    if (lowest == highest) {
      lowest -= _flatRangePad;
      highest += _flatRangePad;
    }
    final double pad = (highest - lowest) * _rangePadFactor;

    return TrendChartScale(
      lowest: lowest - pad,
      highest: highest + pad,
      left: _sideInset,
      right: size.width - _sideInset,
      top: _topInset,
      bottom: size.height - _bottomInset,
      count: points.length,
    );
  }

  void _paintReferenceLine(Canvas canvas, Size size, TrendChartScale scale) {
    final double? reference = referenceValue;
    if (reference == null) {
      return;
    }

    final double y = scale.yFor(reference);
    final Paint paint = Paint()
      ..color = mutedColor
      ..strokeWidth = 1.0;
    double x = _sideInset;
    while (x < size.width - _sideInset) {
      canvas.drawLine(Offset(x, y), Offset(x + _dashWidth, y), paint);
      x += _dashWidth + _dashGap;
    }
    _paintText(
      canvas,
      NumberFormatting.compact(reference),
      axisStyle,
      Offset(0.0, y - _referenceLabelLift),
    );
  }

  void _paintLine(Canvas canvas, List<Offset> plotted) {
    if (plotted.length < _minPointsForLine) {
      return;
    }

    final Path path = Path()..moveTo(plotted.first.dx, plotted.first.dy);
    for (final Offset point in plotted.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = lineColor
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = _strokeWidth,
    );
  }

  void _paintDots(Canvas canvas, List<Offset> plotted) {
    final Paint paint = Paint()..color = lineColor;
    for (int index = 0; index < plotted.length; index++) {
      final Offset point = plotted[index];
      if (index == selectedIndex) {
        canvas.drawCircle(point, _dotRadius * _selectedDotScale, paint);
        continue;
      }
      canvas.drawCircle(point, _dotRadius, paint);
    }
  }

  /// Every how many points a label fits without touching its neighbour.
  int _labelStride(Size size) {
    if (points.length < _minPointsForLine) {
      return 1;
    }

    double widest = 0.0;
    for (final TrendPoint point in points) {
      final double width = math.max(
        _layout(point.label, axisStyle).width,
        _layout(NumberFormatting.compact(point.value), valueStyle).width,
      );
      widest = math.max(widest, width);
    }
    final double spacing = (size.width - _sideInsetTotal) / (points.length - 1);

    return math.max(1, ((widest + _minLabelGap) / spacing).ceil());
  }

  /// Whether the point at [index] carries labels at this [stride].
  ///
  /// The newest always does; points fewer than [stride] before it never do.
  bool _isLabelled(int index, int stride) {
    final int last = points.length - 1;
    if (index == last) {
      return true;
    }

    return index % stride == 0 && last - index >= stride;
  }

  void _paintValueLabels(
    Canvas canvas,
    Size size,
    List<Offset> plotted,
    int stride,
  ) {
    for (int index = 0; index < plotted.length; index++) {
      if (!_isLabelled(index, stride)) {
        continue;
      }
      final TextPainter painter = _layout(
        NumberFormatting.compact(points[index].value),
        valueStyle,
      );
      final double left = (plotted[index].dx - painter.width * _centreFactor)
          .clamp(
            0.0,
            size.width - painter.width,
          );
      painter.paint(
        canvas,
        Offset(left, plotted[index].dy - painter.height - _labelGap),
      );
    }
  }

  void _paintAxisLabels(Canvas canvas, Size size, int stride) {
    final double baseline = size.height - _bottomInset + _labelGap;
    for (int index = 0; index < points.length; index++) {
      if (!_isLabelled(index, stride)) {
        continue;
      }
      final TextPainter painter = _layout(points[index].label, axisStyle);
      final double ratio = index / (points.length - 1);
      final double span = size.width - _sideInsetTotal;
      final double left = switch (index) {
        0 => 0.0,
        _ when index == points.length - 1 => size.width - painter.width,
        _ => _sideInset + span * ratio - painter.width * _centreFactor,
      };
      painter.paint(
        canvas,
        Offset(left.clamp(0.0, size.width - painter.width), baseline),
      );
    }
  }

  void _paintText(Canvas canvas, String text, TextStyle style, Offset at) {
    _layout(text, style).paint(canvas, at);
  }

  TextPainter _layout(String text, TextStyle style) => TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  )..layout();
}
