import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Sections laid out in a grid, each as wide as it asks to be.
class const SectionGrid({
  super.key,

  /// The sections, in reading order.
  required final List<Widget> sections,

  /// Twelfths of a row each section takes; missing entries mean full width.
  required final List<int> widths,
}) extends StatelessWidget {
  static const double _multiColumnMinWidth = 720.0;

  static const int _rowUnits = 12;

  /// Creates a section grid.
  this;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (_, constraints) {
      if (constraints.maxWidth < _multiColumnMinWidth) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: sections,
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final List<int> row in _rows())
            // Not IntrinsicHeight: it leaves LayoutBuilder children unsized,
            // which crashes on the first tap.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.cardGap,
              children: <Widget>[
                for (final int index in row)
                  Expanded(flex: _widthOf(index), child: sections[index]),
              ],
            ),
        ],
      );
    },
  );

  /// Groups section indexes into rows of twelve twelfths or fewer.
  List<List<int>> _rows() {
    final List<List<int>> rows = <List<int>>[];
    List<int> current = <int>[];
    int used = 0;
    for (int index = 0; index < sections.length; index++) {
      final int width = _widthOf(index);
      if (used + width > _rowUnits && current.isNotEmpty) {
        rows.add(current);
        current = <int>[];
        used = 0;
      }
      current.add(index);
      used += width;
    }
    if (current.isNotEmpty) {
      rows.add(current);
    }

    return rows;
  }

  int _widthOf(int index) =>
      index < widths.length ? widths[index].clamp(1, _rowUnits) : _rowUnits;
}
