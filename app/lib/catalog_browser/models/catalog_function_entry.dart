import 'package:clinical_brief/catalog_browser/models/catalog_property.dart';
import 'package:genui/genui.dart';
import 'package:meta/meta.dart';

/// One function the catalog's components can call, as the catalog page
/// lists it.
@immutable
class const CatalogFunctionEntry({
  /// The function's name, e.g. `length`.
  required final String name,

  /// What the function does.
  required final String description,

  /// Its arguments, in schema order.
  required final List<CatalogProperty> arguments,
}) {
  /// The function as the brief agent's prompt lists it, e.g.
  /// `length(value?, min?, max?)`.
  String get signature => '$name${CatalogProperty.parameterListOf(arguments)}';

  /// Creates an entry.
  this;

  /// Reads [function]'s argument schema.
  factory fromFunction(ClientFunction function) => CatalogFunctionEntry(
    name: function.name,
    description: function.description,
    arguments: CatalogProperty.listOf(function.argumentSchema.value),
  );
}
