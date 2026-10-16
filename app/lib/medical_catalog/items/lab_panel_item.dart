import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/models/lab_result.dart';
import 'package:clinical_brief/medical_catalog/widgets/labs/lab_panel.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `LabPanel` component, drawn as [LabPanel].
abstract final class LabPanelItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.section(
    name: 'LabPanel',
    schema: S.object(
      description:
          'One set of results from one day: the values out of range in full, '
          'and a count of the rest. Use it for the latest results when what '
          "matters is where today's numbers sit against their ranges. Use a "
          'TrendChart instead when what matters is the direction over time.',
      properties: <String, Schema>{
        'title': S.string(description: 'Panel name, e.g. "Blood panel".'),
        'source': S.string(
          description: 'Where and when, e.g. "Urgent care - 8 Sep 2026".',
        ),
        'flagged': S.list(
          description: 'Results out of range, most striking first.',
          items: S.object(
            properties: <String, Schema>{
              'name': S.string(description: 'What was measured.'),
              'value': S.string(
                description: 'Value with unit, e.g. "18 ng/mL".',
              ),
              'referenceRange': S.string(
                description: 'Normal range, e.g. "ref 30 - 400".',
              ),
              'status': S.string(
                description:
                    'Where it sits, in one to three words: "Below range", '
                    '"Above range", "Low in range". Nothing else here.',
              ),
              'history': S.string(
                description:
                    'Optional earlier values, shown as a small line under '
                    'the result, e.g. "was 12.4 in Jan 2026".',
              ),
              'tone': CatalogItemFactory.toneSchema(
                'Defaults to warning; raise for a stark value.',
              ),
            },
            required: <String>['name', 'value', 'status'],
          ),
        ),
        'normalSummary': S.string(
          description:
              'How the rest came back, e.g. "7 other markers within range". '
              'Only state a count the record supports.',
        ),
      },
      required: <String>['title', 'flagged'],
    ),
    example: _example,
    build: _build,
  );

  static const String _example = '''
      [
        {
          "id": "panel",
          "component": "LabPanel",
          "title": "Blood panel",
          "source": "Urgent care - 8 Sep 2026",
          "flagged": [
            {
              "name": "Hemoglobin",
              "value": "9.9 g/dL",
              "referenceRange": "ref 12.0 - 15.5",
              "status": "Below range",
              "tone": "critical"
            },
            {
              "name": "Ferritin",
              "value": "19 ng/mL",
              "referenceRange": "ref 15 - 150",
              "status": "Low in range"
            }
          ],
          "normalSummary": "Thyroid and kidney results within range"
        }
      ]
    ''';

  static Widget _build(CatalogItemContext _, JsonMap data) => LabPanel(
    title: data.readString('title'),
    source: data.readOptionalString('source'),
    normalSummary: data.readOptionalString('normalSummary'),
    flagged: data.readList('flagged', LabResult.fromJson),
  );
}
