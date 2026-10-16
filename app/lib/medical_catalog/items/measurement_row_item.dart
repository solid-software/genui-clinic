import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/models/measurement.dart';
import 'package:clinical_brief/medical_catalog/widgets/measurements/measurement_row.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `MeasurementRow` component, drawn as [MeasurementRow].
abstract final class MeasurementRowItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.section(
    name: 'MeasurementRow',
    schema: S.object(
      description:
          'Numbers measured today, shown large as tiles. Use it for the '
          'readings written in the complaint text - blood pressure, oxygen '
          'saturation, pulse, temperature - and for nothing else.',
      properties: <String, Schema>{
        'measurements': S.list(
          description: 'Tiles, most relevant to the complaint first.',
          items: S.object(
            properties: <String, Schema>{
              'label': S.string(description: 'What was measured.'),
              'value': S.string(
                description: 'The reading, exactly as written, e.g. "89%".',
              ),
              'meta': S.string(
                description:
                    'Optional line under the number, for where it sits '
                    'against the record or an earlier reading today, '
                    'e.g. "was 95% at check-in".',
              ),
              'tone': CatalogItemFactory.toneSchema(
                'Raise this only for a reading out of range.',
              ),
            },
            required: <String>['label', 'value'],
          ),
        ),
      },
      required: <String>['measurements'],
    ),
    example: _example,
    build: _build,
  );

  static const String _example = '''
      [
        {
          "id": "today",
          "component": "MeasurementRow",
          "measurements": [
            {
              "label": "Oxygen saturation",
              "value": "89%",
              "meta": "was 95% at check-in",
              "tone": "critical"
            },
            {"label": "Heart rate", "value": "108 bpm", "tone": "warning"},
            {"label": "Blood pressure", "value": "146/88"}
          ]
        }
      ]
    ''';

  static Widget _build(CatalogItemContext _, JsonMap data) => MeasurementRow(
    measurements: data.readList('measurements', Measurement.fromJson),
  );
}
