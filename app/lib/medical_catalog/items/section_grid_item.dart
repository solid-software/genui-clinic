import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/widgets/layout/section_grid.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `SectionGrid` component, drawn as [SectionGrid].
abstract final class SectionGridItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.item(
    name: 'SectionGrid',
    schema: S.object(
      description:
          'Sections laid out in a grid, each as wide as you say. Twelve is a '
          'full row, six a half, four a third; sections flow into rows and '
          'stack on a narrow screen. Use it to lay a whole brief out as a '
          'dashboard, with the leading section full width and the supporting '
          'ones beside each other.',
      properties: <String, Schema>{
        'sections': CatalogItemFactory.childListSchema(
          'Ids of the sections, in reading order.',
        ),
        'widths': S.list(
          description:
              'Width of each section in twelfths, one per section, in the '
              'same order: 12, 6 or 4.',
          items: S.integer(),
        ),
      },
      required: <String>['sections', 'widths'],
    ),
    example: _example,
    build: _build,
  );

  static const String _example = '''
      [
        {
          "id": "layout",
          "component": "SectionGrid",
          "sections": ["today", "trends", "medication", "gaps"],
          "widths": [12, 12, 6, 6]
        }
      ]
    ''';

  static Widget _build(CatalogItemContext itemContext, JsonMap data) =>
      SectionGrid(
        widths: data.readIntList('widths'),
        sections: CatalogItemFactory.childrenOf(itemContext, data, 'sections'),
      );
}
