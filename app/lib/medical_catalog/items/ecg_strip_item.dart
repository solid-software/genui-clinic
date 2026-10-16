import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/widgets/ecg/ecg_strip.dart';
import 'package:clinical_brief/medical_catalog/widgets/layout/section_card.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `EcgStrip` component, drawn as [EcgStrip].
abstract final class EcgStripItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.section(
    name: 'EcgStrip',
    schema: S.object(
      description:
          'A rhythm strip drawn at a given heart rate, for a complaint about '
          'the heartbeat or a pulse that is out of range. The trace is drawn '
          'from the rate and rhythm you give, so both must come from the '
          'record or the complaint. Do not use it to imply a reading that '
          'was not taken.',
      properties: <String, Schema>{
        'rate': S.integer(description: 'Beats per minute.'),
        'irregular': S.boolean(
          description:
              'True only when the record or the complaint says the rhythm is '
              'irregular.',
        ),
        'caption': S.string(
          description: 'Where the rate came from, e.g. "taken during exam".',
        ),
        'footnote': S.string(description: 'Optional muted closing line.'),
        'tone': CatalogItemFactory.toneSchema(
          'Raise this for a rate out of range.',
        ),
      },
      required: <String>['rate'],
    ),
    example: _example,
    build: _build,
  );

  /// Fixed heading: a strip on ECG paper is an ECG, whatever the model
  /// calls it.
  static const String _title = 'ECG';

  static const String _example = '''
      [
        {
          "id": "rhythm",
          "component": "EcgStrip",
          "rate": 110,
          "irregular": true,
          "caption": "standing, recorded today",
          "footnote": "Last ECG on file: normal sinus rhythm, Apr 2022."
        }
      ]
    ''';

  static Widget _build(CatalogItemContext _, JsonMap data) => SectionCard(
    icon: Icons.monitor_heart_outlined,
    title: _title,
    caption: data.readOptionalString('caption'),
    footnote: data.readOptionalString('footnote'),
    trailing: '${data.readInt('rate')} bpm',
    child: EcgStrip(
      rate: data.readInt('rate'),
      irregular: data.readBool('irregular'),
    ),
  );
}
