import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:clinical_brief/medical_catalog/widgets/layout/split_section.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// The `SplitSection` component, drawn as [SplitSection].
abstract final class SplitSectionItem {
  /// The catalog item.
  static final CatalogItem item = CatalogItemFactory.item(
    name: 'SplitSection',
    schema: S.object(
      description:
          'Two columns of sections side by side, the first wider than the '
          'second, stacked on a narrow screen. Use it to lay a brief out as '
          'a dashboard read at once, rather than as one stack read top to '
          'bottom.',
      properties: <String, Schema>{
        'primary': CatalogItemFactory.childListSchema(
          'Ids of the sections in the wider left column.',
        ),
        'secondary': CatalogItemFactory.childListSchema(
          'Ids of the sections in the narrower right column.',
        ),
      },
      required: <String>['primary', 'secondary'],
    ),
    example: _example,
    build: _build,
  );

  static const String _example = '''
      [
        {
          "id": "layout",
          "component": "SplitSection",
          "primary": ["trends", "medication"],
          "secondary": ["gaps", "history"]
        }
      ]
    ''';

  static Widget _build(CatalogItemContext itemContext, JsonMap data) =>
      SplitSection(
        primary: CatalogItemFactory.childrenOf(itemContext, data, 'primary'),
        secondary: CatalogItemFactory.childrenOf(
          itemContext,
          data,
          'secondary',
        ),
      );
}
