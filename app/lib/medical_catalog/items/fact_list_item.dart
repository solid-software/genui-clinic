import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/models/fact_entry.dart';
import 'package:clinical_brief/medical_catalog/widgets/facts/fact_list.dart';
import 'package:clinical_brief/medical_catalog/widgets/layout/section_card.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `FactList` component, drawn as [FactList].
abstract final class FactListItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.section(
    name: 'FactList',
    schema: S.object(
      description:
          'A titled group of chart lines, for facts that have no trend to '
          'plot: history, risk factors, prior imaging, current problems.',
      properties: <String, Schema>{
        'title': S.string(description: 'Group heading.'),
        'footnote': S.string(
          description:
              'Optional muted line under the group. Use it to state an '
              'absence that matters, e.g. "Nothing since.".',
        ),
        'entries': S.list(
          description: 'Lines, most relevant to the complaint first.',
          items: S.object(
            properties: <String, Schema>{
              'label': S.string(description: 'What the fact is.'),
              'value': S.string(description: 'What it says.'),
              'meta': S.string(
                description:
                    'Recency or provenance, shown muted on the right, '
                    'e.g. "since 2018" or "last recorded 2019".',
              ),
              'tone': CatalogItemFactory.toneSchema(
                'Raise this only for a red-flag line.',
              ),
            },
            required: <String>['label'],
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
          "id": "history",
          "component": "FactList",
          "title": "Relevant history",
          "entries": [
            {
              "label": "Smoking",
              "value": "30 pack-years",
              "meta": "last recorded 2019"
            },
            {"label": "Type 2 diabetes", "meta": "since 2018"},
            {"label": "Hypertension", "meta": "since 2016"}
          ]
        }
      ]
    ''';

  static Widget _build(CatalogItemContext _, JsonMap data) => SectionCard(
    icon: Icons.list_alt_outlined,
    title: data.readString('title'),
    footnote: data.readOptionalString('footnote'),
    child: FactList(
      entries: data.readList('entries', FactEntry.fromJson),
    ),
  );
}
