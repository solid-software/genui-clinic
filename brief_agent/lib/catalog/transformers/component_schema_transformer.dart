import 'package:a2ui_agent/a2ui_agent.dart';
import 'package:a2ui_core/a2ui_core.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// A [CatalogTransformer] that rewrites each component's schema.
///
/// Built for an agent's catalog, whose components are plain [ComponentApi]s.
abstract base class ComponentSchemaTransformer extends CatalogTransformer {
  static const String _properties = 'properties';

  /// Creates the transformer.
  const ComponentSchemaTransformer();

  /// [schema], rewritten.
  Map<String, Object?> rewrite(Map<String, Object?> schema);

  @override
  Catalog<C, F> transform<C extends ComponentApi, F extends FunctionApi>(
    Catalog<C, F> catalog,
  ) => catalog.copyWith(
    components: <C>[
      for (final C component in catalog.components.values)
        ComponentApi(
          name: component.name,
          schema: Schema.fromMap(rewrite(component.schema.value)),
        ) as C,
    ],
  );

  /// The properties of [schema], or `null` if it declares none.
  static Map<String, Object?>? propertiesOf(Map<String, Object?> schema) =>
      switch (schema[_properties]) {
        final Map<String, Object?> properties => properties,
        _ => null,
      };

  /// [schema] with [properties] in place of its own.
  static Map<String, Object?> withProperties(
    Map<String, Object?> schema,
    Map<String, Object?> properties,
  ) => <String, Object?>{...schema, _properties: properties};
}
