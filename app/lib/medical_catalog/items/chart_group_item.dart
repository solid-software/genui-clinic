import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/widgets/layout/chart_grid.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `ChartGroup` component, drawn as [ChartGrid].
abstract final class ChartGroupItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.section(
    name: 'ChartGroup',
    schema: S.object(
      description:
          'Places TrendCharts side by side, two per row, when the screen is '
          'wide enough, and stacks them on narrow screens. Every TrendChart '
          'belongs in one. Prefer two charts per group: half a row each is '
          'the normal size for a chart, and a chart alone in a group takes '
          'the whole row.',
      properties: <String, Schema>{
        'children': CatalogItemFactory.childListSchema(
          'Ids of the TrendChart components in this group, in ranking order.',
        ),
      },
      required: <String>['children'],
    ),
    example: _example,
    build: _build,
  );

  static const String _example = '''
      [
        {
          "id": "trends",
          "component": "ChartGroup",
          "children": ["hemoglobin", "weight"]
        },
        {
          "id": "hemoglobin",
          "component": "TrendChart",
          "title": "Hemoglobin",
          "trailing": "g/L - 18 months",
          "caption": "4 results, 4 different doctors",
          "points": [
            {"label": "Mar 25", "value": 141},
            {"label": "Jul 26", "value": 118}
          ]
        },
        {
          "id": "weight",
          "component": "TrendChart",
          "title": "Weight",
          "trailing": "kg - 3 years",
          "caption": "-7 kg in 11 months, never reported",
          "points": [
            {"label": "2023", "value": 89},
            {"label": "Today", "value": 82}
          ]
        }
      ]
    ''';

  static Widget _build(CatalogItemContext itemContext, JsonMap data) =>
      ChartGrid(
        children: CatalogItemFactory.childrenOf(itemContext, data, 'children'),
      );
}
