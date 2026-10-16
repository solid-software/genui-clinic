import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/models/fact_entry.dart';
import 'package:clinical_brief/medical_catalog/widgets/safety/safety_banner.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `SafetyBanner` component, drawn as [SafetyBanner].
abstract final class SafetyBannerItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.section(
    name: 'SafetyBanner',
    schema: S.object(
      description:
          'The pinned safety band at the very top of a brief. Always emit '
          'exactly one of these as the first child of the root, with the '
          'columns Allergies, Active medication and Anticoagulation.',
      properties: <String, Schema>{
        'entries': S.list(
          description: 'One column per safety fact, in reading order.',
          items: S.object(
            properties: <String, Schema>{
              'label': S.string(description: 'Column heading.'),
              'value': S.string(
                description:
                    'The fact itself. Never leave this blank: write '
                    '"None known" or "None" when there is nothing to report.',
              ),
            },
            required: <String>['label', 'value'],
          ),
        ),
        'tone': CatalogItemFactory.toneSchema(
          'Use "critical" when any column carries an allergy or an '
          'anticoagulant, otherwise "neutral".',
        ),
      },
      required: <String>['entries'],
    ),
    example: _example,
    build: _build,
  );

  static const String _example = '''
      [
        {
          "id": "safety",
          "component": "SafetyBanner",
          "tone": "critical",
          "entries": [
            {"label": "Allergies", "value": "None known"},
            {
              "label": "Active medication",
              "value": "Amlodipine 10 mg - Metformin 1000 mg"
            },
            {"label": "Anticoagulation", "value": "None"}
          ]
        }
      ]
    ''';

  static Widget _build(CatalogItemContext _, JsonMap data) => SafetyBanner(
    entries: data.readList('entries', FactEntry.fromJson),
    tone: ClinicalTone.fromWire(data['tone']),
  );
}
