import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/models/bar_entry.dart';
import 'package:clinical_brief/medical_catalog/widgets/bar_comparison/bar_comparison.dart';
import 'package:clinical_brief/medical_catalog/widgets/layout/section_card.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `BarComparison` component, drawn as [BarComparison].
abstract final class BarComparisonItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.section(
    name: 'BarComparison',
    schema: S.object(
      description:
          'Values compared as bars, with an optional target drawn across '
          'them. Use it to compare things measured on the same scale, or one '
          'value against its target. For a value over time use a TrendChart.',
      properties: <String, Schema>{
        'title': S.string(description: 'Group heading.'),
        'caption': S.string(description: 'One line of context.'),
        'target': S.number(
          description: 'Optional target drawn as a line across the bars.',
        ),
        'targetLabel': S.string(
          description: 'What the target is, e.g. "target below 7%".',
        ),
        'entries': S.list(
          description: 'Bars, in the order they should be read.',
          items: S.object(
            properties: <String, Schema>{
              'label': S.string(description: 'What the bar stands for.'),
              'value': S.number(description: 'The plotted value.'),
              'display': S.string(
                description: 'How the value should read, e.g. "9.6 %".',
              ),
              'tone': CatalogItemFactory.toneSchema(
                'Raise this for a bar past its target.',
              ),
            },
            required: <String>['label', 'value'],
          ),
        ),
      },
      required: <String>['title', 'entries'],
    ),
    example: _example,
    build: _build,
  );

  static const String _example = '''
      [
        {
          "id": "hba1c-vs-target",
          "component": "BarComparison",
          "title": "HbA1c against target",
          "target": 7,
          "targetLabel": "Target below 7%",
          "entries": [
            {"label": "2024", "value": 9.1, "display": "9.1 %"},
            {"label": "2025", "value": 9.4, "display": "9.4 %"},
            {
              "label": "May 2026",
              "value": 9.6,
              "display": "9.6 %",
              "tone": "warning"
            }
          ]
        }
      ]
    ''';

  static Widget _build(CatalogItemContext _, JsonMap data) => SectionCard(
    icon: Icons.bar_chart_rounded,
    title: data.readString('title'),
    caption: data.readOptionalString('caption'),
    child: BarComparison(
      entries: data.readList('entries', BarEntry.fromJson),
      target: data.readOptionalDouble('target'),
      targetLabel: data.readOptionalString('targetLabel'),
    ),
  );
}
