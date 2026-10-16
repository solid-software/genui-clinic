import 'package:clinical_brief/medical_catalog/models/trend_point.dart';
import 'package:clinical_brief/medical_catalog/widgets/trends/reading_note.dart';
import 'package:clinical_brief/medical_catalog/widgets/trends/trend_chart_painter.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// A labelled sparkline of one measurement; a tapped reading is named below.
class const TrendChart({
  super.key,

  /// Points to plot, oldest first.
  required final List<TrendPoint> points,

  /// Optional threshold drawn as a dashed line.
  final double? referenceValue,

  /// Whether to draw the shorter version, without per-point labels.
  final bool compact = false,
}) extends StatefulWidget {
  static const _chartHeight = 150.0;
  static const _compactChartHeight = 96.0;

  /// Creates a trend chart.
  this;

  @override
  State<TrendChart> createState() => _TrendChartState();
}

class _TrendChartState extends State<TrendChart> {
  static const _insetsMultiplier = 2;
  static const _insets = TrendChartPainter.sideInset * _insetsMultiplier;

  int? _selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.points.isEmpty) {
      return Text(
        'No measurements on file.',
        style: theme.textTheme.bodySmall,
      );
    }

    final lineColor = theme.colorScheme.primary;
    final selected = _selectedPoint();

    return Column(
      crossAxisAlignment: .start,
      children: [
        SizedBox(
          height: widget.compact
              ? TrendChart._compactChartHeight
              : TrendChart._chartHeight,
          child: LayoutBuilder(
            builder: (_, constraints) => GestureDetector(
              behavior: .opaque,
              onTapDown: (details) =>
                  _select(details.localPosition.dx, constraints.maxWidth),
              child: CustomPaint(
                size: .infinite,
                painter: _painter(theme, lineColor),
              ),
            ),
          ),
        ),
        if (selected != null) ...[
          const SizedBox(height: AppSpacing.sm),
          ReadingNote(point: selected, color: lineColor),
        ],
      ],
    );
  }

  @override
  void didUpdateWidget(TrendChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // A stale index would point at another reading, or past the end.
    if (!_samePoints(oldWidget.points, widget.points)) {
      _selected = null;
    }
  }

  /// Whether two point lists hold the same readings.
  ///
  /// Not identity: parents pass a fresh list on every rebuild.
  static bool _samePoints(List<TrendPoint> a, List<TrendPoint> b) {
    if (a.length != b.length) {
      return false;
    }
    for (int index = 0; index < a.length; index++) {
      if (a[index].label != b[index].label ||
          a[index].value != b[index].value) {
        return false;
      }
    }

    return true;
  }

  /// Selects the reading nearest the tap, or clears it when tapped again.
  ///
  /// Measured within the painter's side insets, where the points sit.
  void _select(double dx, double width) {
    final last = widget.points.length - 1;
    const inset = TrendChartPainter.sideInset;
    final span = width - _insets;
    final spacing = last == 0 || span <= 0 ? width : span / last;
    final nearest = last == 0
        ? 0
        : ((dx - inset) / spacing).round().clamp(0, last);
    setState(() => _selected = _selected == nearest ? null : nearest);
  }

  /// The tapped reading, or `null` when none is selected.
  TrendPoint? _selectedPoint() {
    final index = _selected;

    return index == null || index >= widget.points.length
        ? null
        : widget.points[index];
  }

  TrendChartPainter _painter(ThemeData theme, Color lineColor) {
    final muted = theme.colorScheme.onSurfaceVariant;

    return TrendChartPainter(
      points: widget.points,
      lineColor: lineColor,
      mutedColor: muted,
      valueStyle:
          theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ) ??
          const TextStyle(),
      axisStyle:
          theme.textTheme.bodySmall?.copyWith(color: muted) ??
          const TextStyle(),
      referenceValue: widget.referenceValue,
      labelPoints: !widget.compact,
      selectedIndex: _selected,
    );
  }
}
