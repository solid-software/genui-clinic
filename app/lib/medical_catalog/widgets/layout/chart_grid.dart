import 'package:clinical_brief/medical_catalog/widgets/layout/chart_row.dart';
import 'package:flutter/material.dart';

/// Grid of charts, two to a row when there is room, one when not.
class const ChartGrid({
  super.key,

  /// The charts, in ranking order.
  required final List<Widget> children,
}) extends StatelessWidget {
  static const double _twoColumnMinWidth = 640.0;
  static const int _maxColumns = 2;

  /// Creates a chart grid.
  this;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (_, constraints) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final List<Widget> row in _rows(
          columns: constraints.maxWidth >= _twoColumnMinWidth ? _maxColumns : 1,
        ))
          ChartRow(children: row),
      ],
    ),
  );

  /// Groups [children] into rows of [columns], keeping their order.
  List<List<Widget>> _rows({required int columns}) => <List<Widget>>[
    for (int start = 0; start < children.length; start += columns)
      children.sublist(
        start,
        start + columns > children.length ? children.length : start + columns,
      ),
  ];
}
