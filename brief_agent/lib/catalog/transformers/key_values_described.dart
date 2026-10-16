import 'package:brief_agent/catalog/transformers/component_schema_transformer.dart';

/// Adds the allowed values of a map's keys to their descriptions.
///
/// The Express prompt lists the values of a property, but only the
/// descriptions of map keys, so a key such as `tone` would lose its values.
final class KeyValuesDescribed extends ComponentSchemaTransformer {
  static const _items = 'items';
  static const _description = 'description';
  static const _enum = 'enum';

  /// Creates the transformer.
  const KeyValuesDescribed();

  @override
  Map<String, Object?> rewrite(Map<String, Object?> schema) =>
      switch (ComponentSchemaTransformer.propertiesOf(schema)) {
        final properties? => ComponentSchemaTransformer.withProperties(
          schema,
          properties.map((k, v) => MapEntry(k, _withKeysDescribed(v))),
        ),
        _ => schema,
      };

  /// [property], a map or a list of maps, with its keys' values described.
  static Object? _withKeysDescribed(Object? property) {
    if (property is! Map<String, Object?>) return property;
    final items = property[_items];
    final map = items is Map<String, Object?> ? items : property;
    final keys = ComponentSchemaTransformer.propertiesOf(map);
    if (keys == null) return property;
    final described = ComponentSchemaTransformer.withProperties(
      map,
      keys.map((k, v) => MapEntry(k, _valuesDescribed(v))),
    );
    return identical(map, property)
        ? described
        : {...property, _items: described};
  }

  /// [key] with its allowed values added to its description, in the words
  /// the Express prompt uses for a property's values.
  static Object? _valuesDescribed(Object? key) {
    if (key is! Map<String, Object?>) return key;
    final values = key[_enum];
    if (values is! List<Object?>) return key;
    final oneOf = "Must be one of: ${values.map((v) => "'$v'").join(', ')}";
    return {
      ...key,
      _description: switch (key[_description]) {
        final String description => '$description $oneOf',
        _ => oneOf,
      },
    };
  }
}
