import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/models/care_gap.dart';
import 'package:clinical_brief/medical_catalog/widgets/care_gaps/care_gap_list.dart';
import 'package:clinical_brief/medical_catalog/widgets/layout/section_card.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `CareGapList` component, drawn as [CareGapList].
abstract final class CareGapListItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.section(
    name: 'CareGapList',
    schema: S.object(
      description:
          'A checklist of follow-ups the record shows as due, overdue or '
          'never done: a repeat scan advised years ago, a test left '
          'inconclusive, a risk factor last confirmed long ago. Use it when '
          'what is missing from the record matters more than what is in it.',
      properties: <String, Schema>{
        'title': S.string(description: 'Group heading.'),
        'gaps': S.list(
          description: 'Items, longest overdue or most relevant first.',
          items: S.object(
            properties: <String, Schema>{
              'item': S.string(description: 'What is outstanding.'),
              'due': S.string(
                description:
                    'When it was due or last done, shown on the right, '
                    'e.g. "due 2021" or "last done 2018".',
              ),
              'status': S.string(
                description:
                    'Optional line under the item, for what the record says '
                    'about it, e.g. "advised after polyp removal".',
              ),
              'tone': CatalogItemFactory.toneSchema(
                'Raise this for an item long overdue.',
              ),
            },
            required: <String>['item', 'due'],
          ),
        ),
      },
      required: <String>['title', 'gaps'],
    ),
    example: _example,
    build: _build,
  );

  static const String _example = '''
      [
        {
          "id": "gaps",
          "component": "CareGapList",
          "title": "Follow-ups on file",
          "gaps": [
            {
              "item": "Colonoscopy repeat",
              "due": "due 2021",
              "status": "advised after two polyps were removed in 2016",
              "tone": "warning"
            },
            {"item": "Chest X-ray", "due": "last done Nov 2021"}
          ]
        }
      ]
    ''';

  static Widget _build(CatalogItemContext _, JsonMap data) => SectionCard(
    icon: Icons.pending_actions_outlined,
    title: data.readString('title'),
    child: CareGapList(
      gaps: data.readList('gaps', CareGap.fromJson),
    ),
  );
}
