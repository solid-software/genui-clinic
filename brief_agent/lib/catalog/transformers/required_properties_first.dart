import 'package:brief_agent/catalog/transformers/component_schema_transformer.dart';
import 'package:collection/collection.dart';

/// Lists each component's required properties first, in schema order.
///
/// Express fills properties by position, as the prompt lists them. Upstream
/// catalogs list required properties first; GenUI's do not always (Column:
/// justify, align, children).
final class const RequiredPropertiesFirst() extends ComponentSchemaTransformer {
  static const _required = 'required';

  @override
  Map<String, Object?> rewrite(Map<String, Object?> schema) {
    final properties = ComponentSchemaTransformer.propertiesOf(schema);
    final required = schema[_required];
    return properties == null || required is! List<Object?>
        ? schema
        : ComponentSchemaTransformer.withProperties(
            schema,
            Map.fromEntries(
              properties.entries.sortedBy(
                (property) => required.contains(property.key) ? 1 : 0,
              ),
            ),
          );
  }
}
