import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:meta/meta.dart';

/// One property of a catalog component, or argument of a catalog function,
/// read from its JSON schema.
@immutable
class const CatalogProperty({
  /// The property's key, e.g. `tone`.
  required final String name,

  /// What the property is for; empty when the schema does not say.
  required final String description,

  /// Whether it must be set.
  required final bool isRequired,

  /// Whether its value can come from the data model instead of being
  /// written into the component.
  required final bool isBindable,
}) {
  static const _choiceKeys = ['allOf', 'anyOf', 'oneOf'];

  /// Where A2UI's bindable types are defined, e.g. `DynamicString`.
  static const _dynamicType = r'/$defs/Dynamic';

  /// The keys a data binding is written under: `@path` for an ordinary
  /// dynamic value, `path` for a `ChildList` template's data source.
  static const _bindingKeys = ['path', '@path'];

  /// The property as a parameter: `tone?` when it may be left out.
  String get parameter => isRequired ? name : '$name?';

  /// Creates a property.
  this;

  /// The property [name], as [schema] describes it.
  factory fromSchema(
    String name,
    Map<String, Object?> schema, {
    required bool isRequired,
  }) => CatalogProperty(
    name: name,
    description: schema.readString('description'),
    isRequired: isRequired,
    isBindable: _isBindable(schema),
  );

  /// The properties of the object [schema] describes, in schema order.
  static List<CatalogProperty> listOf(Map<String, Object?> schema) {
    final properties = schema.readObject('properties');
    final required = schema.readStringList('required');

    return [
      for (final name in properties.keys)
        CatalogProperty.fromSchema(
          name,
          properties.readObject(name),
          isRequired: required.contains(name),
        ),
    ];
  }

  /// [properties] as a parameter list, e.g. `(entries, tone?)`.
  static String parameterListOf(Iterable<CatalogProperty> properties) =>
      '(${properties.map((property) => property.parameter).join(', ')})';

  /// Whether [schema] is an A2UI dynamic type, or offers one or a data
  /// binding (an object with a `path` or `@path`) among its choices.
  static bool _isBindable(Map<String, Object?> schema) => switch (schema) {
    {r'$ref': final String type} => type.contains(_dynamicType),
    _ =>
      _choiceKeys
          .expand(schema.readObjectList)
          .any(
            (choice) =>
                _isBindable(choice) ||
                _bindingKeys.any(
                  choice.readObject('properties').containsKey,
                ),
          ),
  };
}
