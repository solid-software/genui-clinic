import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/models/imaging_event.dart';
import 'package:clinical_brief/medical_catalog/widgets/imaging/imaging_timeline.dart';
import 'package:clinical_brief/medical_catalog/widgets/layout/section_card.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `ImagingTimeline` component, drawn as [ImagingTimeline].
abstract final class ImagingTimelineItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.section(
    name: 'ImagingTimeline',
    schema: S.object(
      description:
          'Scans, X-rays and other studies on a time line, oldest first. Use '
          'it when what was imaged, and how long ago, bears on the '
          'complaint - especially when the gap since the last study is part '
          'of the picture.',
      properties: <String, Schema>{
        'title': S.string(description: 'Group heading, e.g. "Chest imaging".'),
        'sinceNote': S.string(
          description:
              'What has happened since the last study, e.g. "Nothing since '
              'November 2021.".',
        ),
        'events': S.list(
          description: 'Studies, oldest first.',
          items: S.object(
            properties: <String, Schema>{
              'modality': S.string(description: 'What was done.'),
              'date': S.string(description: 'When, e.g. "Nov 2021".'),
              'conclusion': S.string(description: 'What it showed.'),
              'image': S.string(
                description:
                    'The "image" path from the record entry, exactly, when '
                    'it has one. Shown as a thumbnail the doctor can open.',
              ),
              'tone': CatalogItemFactory.toneSchema(
                'Raise this only for a red-flag study.',
              ),
            },
            required: <String>['modality', 'date', 'conclusion'],
          ),
        ),
      },
      required: <String>['title', 'events'],
    ),
    example: _example,
    build: _build,
  );

  static const String _example = '''
      [
        {
          "id": "imaging",
          "component": "ImagingTimeline",
          "title": "Chest imaging",
          "sinceNote": "Nothing since November 2021.",
          "events": [
            {
              "modality": "Chest X-ray",
              "date": "Nov 2021",
              "conclusion": "No focal changes"
            }
          ]
        }
      ]
    ''';

  static Widget _build(CatalogItemContext _, JsonMap data) => SectionCard(
    icon: Icons.timeline,
    title: data.readString('title'),
    child: ImagingTimeline(
      events: data.readList('events', ImagingEvent.fromJson),
      sinceNote: data.readOptionalString('sinceNote'),
    ),
  );
}
