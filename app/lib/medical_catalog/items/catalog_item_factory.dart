import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/medical_catalog/items/item_context.dart';
import 'package:clinical_brief/medical_catalog/motion/motion_card.dart';
import 'package:flutter/widgets.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// What the medical catalog items are built from.
abstract final class CatalogItemFactory {
  /// Sample A2UI, as a JSON array of components, for each catalog item's
  /// name. The catalog browser's preview feature reads this to draw an
  /// example of the component.
  static final Map<String, String> examples = <String, String>{};

  /// A catalog item built from its JSON data.
  static ComponentImplementation item({
    required String name,
    required Schema schema,
    required String example,
    required Widget Function(ItemContext itemContext, Map<String, Object?> data)
    build,
  }) {
    examples[name] = example;

    return ComponentImplementation(
      name: name,
      schema: schema,
      builder: (context, node, props, buildChild) {
        final itemContext = ItemContext(context, node, props, buildChild);

        return build(itemContext, itemContext.data);
      },
    );
  }

  /// An [item] drawn as a brief section that moves between briefs.
  static ComponentImplementation section({
    required String name,
    required Schema schema,
    required String example,
    required Widget Function(ItemContext itemContext, Map<String, Object?> data)
    build,
  }) => item(
    name: name,
    schema: schema,
    example: example,
    build: (itemContext, data) =>
        MotionCard.section(itemContext, build(itemContext, data)),
  );

  /// The widgets for the children referenced under [key].
  static List<Widget> childrenOf(ItemContext itemContext, String key) => [
    for (final child in itemContext.props.children(key))
      itemContext.buildChild(child),
  ];

  /// Schema for a property listing child component ids.
  ///
  /// A2UI's common `ChildList` type, so the agent's SDK knows the ids name
  /// components: it prompts for them as children and checks they are reached.
  static Schema childListSchema(String description) => Schema.combined(
    $ref: r'common_types.json#/$defs/ChildList',
    description: description,
  );

  /// Schema for a `tone` property.
  static Schema toneSchema(String description) => Schema.string(
    description: description,
    enumValues: ClinicalTone.wireNames,
  );
}
