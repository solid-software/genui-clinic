import 'package:clinical_brief/catalog_browser/enums/catalog_origin.dart';
import 'package:clinical_brief/catalog_browser/models/catalog_property.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:collection/collection.dart';
import 'package:genui/genui.dart';
import 'package:meta/meta.dart';

/// One component of the catalog, as the catalog page shows it.
@immutable
class const CatalogEntry({
  /// The component's name, e.g. `SafetyBanner`.
  required final String name,

  /// Where the component comes from.
  required final CatalogOrigin origin,

  /// What the component is for; empty when its schema does not say.
  required final String description,

  /// Its properties: the required ones first, each group in schema order.
  required final List<CatalogProperty> properties,
}) {
  /// The property GenUI adds to every schema to name the component.
  static const _nameKey = 'component';

  /// The properties as a parameter list, e.g. `(entries, tone?)`.
  String get parameterList => CatalogProperty.parameterListOf(properties);

  /// Creates an entry.
  this;

  /// Reads [item]'s schema.
  factory fromItem(CatalogItem item, {required CatalogOrigin origin}) {
    final schema = item.dataSchema.value;

    return CatalogEntry(
      name: item.name,
      origin: origin,
      description: schema.readString('description'),
      properties: CatalogProperty.listOf(schema)
          .where((property) => property.name != _nameKey)
          .sortedBy((property) => property.isRequired ? 0 : 1),
    );
  }
}
