import 'package:brief_agent/catalog/transformers/component_schema_transformer.dart';

/// Marks GenUI's child lists, such as Column's `children`, as A2UI's common
/// `ChildList` type.
///
/// GenUI declares them inline, as ids or a template, without referring to
/// the common type. Unmarked, the SDK would prompt for plain strings and find
/// every child unreachable from `root`.
final class ChildListsMarked extends ComponentSchemaTransformer {
  static const _childList =
      r'https://a2ui.org/specification/v0_9/common_types.json#/$defs/ChildList';
  static const _ref = r'$ref';
  static const _description = 'description';

  /// Creates the transformer.
  const ChildListsMarked();

  @override
  Map<String, Object?> rewrite(Map<String, Object?> schema) =>
      switch (ComponentSchemaTransformer.propertiesOf(schema)) {
        final properties? => ComponentSchemaTransformer.withProperties(
          schema,
          properties.map(
            (k, v) => .new(k, switch (v) {
              final Map<String, Object?> list when _isInlineChildList(list) => {
                _ref: _childList,
                if (list[_description] case final String description)
                  _description: description,
              },
              _ => v,
            }),
          ),
        ),
        _ => schema,
      };

  /// Whether [property] is ids or a template, the shape of a GenUI child
  /// list.
  static bool _isInlineChildList(Map<String, Object?> property) =>
      switch (property['oneOf'] ?? property['anyOf']) {
        final List<Object?> branches =>
          branches.any(_isTemplate) && branches.any(_isIdList),
        _ => false,
      };

  static bool _isTemplate(Object? branch) => switch (branch) {
    {'properties': final Map<String, Object?> properties} =>
      properties.containsKey('componentId') && properties.containsKey('path'),
    _ => false,
  };

  static bool _isIdList(Object? branch) => switch (branch) {
    {'type': 'array'} => true,
    _ => false,
  };
}
