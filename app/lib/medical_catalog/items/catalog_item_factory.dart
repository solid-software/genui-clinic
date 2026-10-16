import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/motion/motion_card.dart';
import 'package:flutter/widgets.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// What the medical catalog items are built from.
abstract final class CatalogItemFactory {
  /// A catalog item built from its JSON data.
  static CatalogItem item({
    required String name,
    required Schema schema,
    required String example,
    required Widget Function(CatalogItemContext itemContext, JsonMap data)
    build,
  }) => CatalogItem(
    name: name,
    dataSchema: schema,
    exampleData: <String Function()>[() => example],
    widgetBuilder: (itemContext) =>
        build(itemContext, itemContext.data as JsonMap),
  );

  /// An [item] drawn as a brief section that moves between briefs.
  static CatalogItem section({
    required String name,
    required Schema schema,
    required String example,
    required Widget Function(CatalogItemContext itemContext, JsonMap data)
    build,
  }) => item(
    name: name,
    schema: schema,
    example: example,
    build: (itemContext, data) =>
        MotionCard.section(itemContext, build(itemContext, data)),
  );

  /// The widgets for the component ids listed under [key].
  static List<Widget> childrenOf(
    CatalogItemContext itemContext,
    JsonMap data,
    String key,
  ) => <Widget>[
    for (final String id in data.readStringList(key))
      itemContext.buildChild(id),
  ];

  /// Schema for a property listing child component ids.
  ///
  /// A2UI's common `ChildList` type, so the agent's SDK knows the ids name
  /// components: it prompts for them as children and checks they are reached.
  static Schema childListSchema(String description) => S.combined(
    $ref: '$commonTypesSchemaId#/\$defs/ChildList',
    description: description,
  );

  /// Schema for a `tone` property.
  static Schema toneSchema(String description) =>
      S.string(description: description, enumValues: ClinicalTone.wireNames);
}
