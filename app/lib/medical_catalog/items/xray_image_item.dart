import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/widgets/imaging/xray_image.dart';
import 'package:clinical_brief/medical_catalog/widgets/layout/section_card.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `XRayImage` component, drawn as [XRayImage].
abstract final class XRayImageItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.section(
    name: 'XRayImage',
    schema: S.object(
      description:
          'An X-ray or CT image from the record, shown large, for the study '
          'that bears most on the complaint. Use it only for a study whose '
          'record entry has an "image" path, and copy that path exactly. '
          'Other studies with images go in an ImagingTimeline with their '
          'image, as thumbnails.',
      properties: <String, Schema>{
        'title': S.string(
          description: 'Heading, e.g. "Chest X-ray" or "CT abdomen".',
        ),
        'image': S.string(
          description: 'The "image" path from the record entry, exactly.',
        ),
        'date': S.string(description: 'When it was taken, e.g. "Nov 2021".'),
        'conclusion': S.string(description: 'The reported conclusion.'),
        'caption': S.string(
          description:
              'Optional line under the heading, e.g. "No chest imaging '
              'since".',
        ),
      },
      required: <String>['title', 'image', 'date', 'conclusion'],
    ),
    example: _example,
    build: _build,
  );

  static const String _example = '''
      [
        {
          "id": "chest-film",
          "component": "XRayImage",
          "title": "Chest X-ray",
          "image": "assets/imaging/john_miller_chest_2021.png",
          "date": "Nov 2021",
          "conclusion": "No focal changes",
          "caption": "The only chest imaging on file"
        }
      ]
    ''';

  static Widget _build(CatalogItemContext _, JsonMap data) => SectionCard(
    icon: Icons.image_outlined,
    title: data.readString('title'),
    caption: data.readOptionalString('caption'),
    child: XRayImage(
      image: data.readString('image'),
      date: data.readString('date'),
      conclusion: data.readString('conclusion'),
    ),
  );
}
