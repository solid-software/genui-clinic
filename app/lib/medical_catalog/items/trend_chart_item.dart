import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/models/trend_point.dart';
import 'package:clinical_brief/medical_catalog/widgets/layout/section_card.dart';
import 'package:clinical_brief/medical_catalog/widgets/trends/trend_chart.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `TrendChart` component, drawn as [TrendChart].
abstract final class TrendChartItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.item(
    name: 'TrendChart',
    schema: S.object(
      description:
          'A measurement plotted over time. Prefer this over any list or '
          'sentence whenever a value has two or more readings on file: the '
          'shape of the line is the finding. Always place it inside a '
          'ChartGroup rather than directly in a Column.',
      properties: <String, Schema>{
        'title': S.string(description: 'Name of the measurement.'),
        'trailing': S.string(
          description:
              'Unit and period, e.g. "g/L - 18 months". Shown top right.',
        ),
        'caption': S.string(
          description:
              'One line of context that the numbers alone do not carry, '
              'e.g. "4 results, 4 different doctors" or '
              '"-7 kg in 11 months, never reported".',
        ),
        'points': S.list(
          description: 'Readings, oldest first.',
          items: S.object(
            properties: <String, Schema>{
              'label': S.string(description: 'Short axis label, e.g. Mar 25.'),
              'value': S.number(description: 'The measured value.'),
              'note': S.string(
                description:
                    'What the record says about this one reading - who took '
                    'it, at which visit, what was written that day. Shown '
                    'when the doctor taps the point, so it should add '
                    'something the line does not already say.',
              ),
            },
            required: <String>['label', 'value'],
          ),
        ),
        'compact': S.boolean(
          description:
              'Half height, with the readings named in the caption instead '
              'of on the line. Use it when several charts share the screen, '
              'or when the shape matters more than each value.',
        ),
        'referenceValue': S.number(
          description:
              'Optional threshold drawn as a dashed line, normally the limit '
              'of normal that the series is crossing.',
        ),
        'tone': CatalogItemFactory.toneSchema(
          'Use "warning" or "critical" when the trend itself is the '
          'concern, not merely the latest value.',
        ),
      },
      required: <String>['title', 'points'],
    ),
    example: _example,
    build: _build,
  );

  static const String _example = '''
      [
        {
          "id": "hemoglobin",
          "component": "TrendChart",
          "title": "Hemoglobin",
          "trailing": "g/L - 18 months",
          "caption": "4 results, 4 different doctors",
          "referenceValue": 130,
          "points": [
            {
              "label": "Mar 25",
              "value": 141,
              "note": "Annual review, Dr. Bennett"
            },
            {"label": "Sep 25", "value": 132},
            {"label": "Feb 26", "value": 126},
            {"label": "Jul 26", "value": 118}
          ]
        }
      ]
    ''';

  static Widget _build(CatalogItemContext _, JsonMap data) => SectionCard(
    icon: Icons.show_chart_rounded,
    title: data.readString('title'),
    trailing: data.readOptionalString('trailing'),
    caption: data.readOptionalString('caption'),
    child: TrendChart(
      compact: data.readBool('compact'),
      points: data.readList('points', TrendPoint.fromJson),
      referenceValue: data.readOptionalDouble('referenceValue'),
    ),
  );
}
