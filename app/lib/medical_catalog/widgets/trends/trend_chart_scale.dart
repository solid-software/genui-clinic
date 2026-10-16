/// Maps data values onto canvas coordinates for `TrendChartPainter`.
class TrendChartScale {
  static const int _minPointsToSpan = 2;
  static const double _centreFactor = 0.5;

  /// The value drawn at [bottom].
  final double lowest;

  /// The value drawn at [top].
  final double highest;

  /// The x of the first point.
  final double left;

  /// The x of the last point.
  final double right;

  /// The y of [highest].
  final double top;

  /// The y of [lowest].
  final double bottom;

  /// How many points are spread from [left] to [right].
  final int count;

  /// Creates a scale for [count] points between [lowest] and [highest].
  const TrendChartScale({
    required this.lowest,
    required this.highest,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
    required this.count,
  });

  /// The x of the point at [index]; the middle when there is only one.
  double xFor(int index) {
    if (count < _minPointsToSpan) {
      return (left + right) * _centreFactor;
    }

    final double ratio = index / (count - 1);

    return left + (right - left) * ratio;
  }

  /// The y of [value]; the middle when all values are equal.
  double yFor(double value) {
    final double span = highest - lowest;
    if (span <= 0) {
      return (top + bottom) * _centreFactor;
    }

    final double ratio = (value - lowest) / span;

    return bottom - (bottom - top) * ratio;
  }
}
