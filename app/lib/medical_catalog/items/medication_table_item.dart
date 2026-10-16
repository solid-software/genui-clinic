import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/models/medication_line.dart';
import 'package:clinical_brief/medical_catalog/widgets/layout/section_card.dart';
import 'package:clinical_brief/medical_catalog/widgets/medications/medication_table.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `MedicationTable` component, drawn as [MedicationTable].
abstract final class MedicationTableItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.section(
    name: 'MedicationTable',
    schema: S.object(
      description:
          'The medication list as a table. Use it when the complaint is '
          'about what the patient takes - a review, a new prescription, a '
          'symptom that medication bears on - rather than repeating the '
          'banner, which only names the medicines.',
      properties: <String, Schema>{
        'title': S.string(description: 'Group heading.'),
        'footnote': S.string(
          description: 'Optional muted line under the table.',
        ),
        'medications': S.list(
          description: 'Rows, most relevant to the complaint first.',
          items: S.object(
            properties: <String, Schema>{
              'name': S.string(description: 'The medicine.'),
              'dose': S.string(description: 'The dose as written.'),
              'schedule': S.string(description: 'How it is taken.'),
              'note': S.string(
                description:
                    'Optional line under the name, for what the record says '
                    'about it, e.g. "over the counter, patient-reported".',
              ),
              'tone': CatalogItemFactory.toneSchema(
                'Raise this only for a row that needs attention.',
              ),
            },
            required: <String>['name', 'dose', 'schedule'],
          ),
        ),
      },
      required: <String>['title', 'medications'],
    ),
    example: _example,
    build: _build,
  );

  static const String _example = '''
      [
        {
          "id": "medication",
          "component": "MedicationTable",
          "title": "Current medication",
          "medications": [
            {
              "name": "Apixaban",
              "dose": "5 mg",
              "schedule": "twice daily",
              "note": "anticoagulant, since 2019"
            },
            {
              "name": "Naproxen",
              "dose": "500 mg",
              "schedule": "twice daily",
              "note": "over the counter, patient-reported since March 2026",
              "tone": "warning"
            }
          ]
        }
      ]
    ''';

  static Widget _build(CatalogItemContext _, JsonMap data) {
    final List<MedicationLine> medications = data.readList(
      'medications',
      MedicationLine.fromJson,
    );

    return SectionCard(
      icon: Icons.medication_outlined,
      title: data.readString('title'),
      // The count is the app's, not the model's: it cannot be wrong.
      trailing: medications.length == 1
          ? '1 medicine'
          : '${medications.length} medicines',
      footnote: data.readOptionalString('footnote'),
      child: MedicationTable(medications: medications),
    );
  }
}
