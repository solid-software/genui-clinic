import 'package:clinical_brief/catalog_browser/enums/catalog_origin.dart';
import 'package:clinical_brief/catalog_browser/models/catalog_entry.dart';
import 'package:clinical_brief/catalog_browser/models/catalog_function_entry.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:genui/genui.dart';

/// The catalog page's state: the components and functions, the search, the
/// origin shown and the component open.
class CatalogBrowserController._(
  /// Every component: the medical ones first, each origin in catalog order.
  final List<CatalogEntry> entries,

  /// The functions the components can call.
  final List<CatalogFunctionEntry> functions,

  /// The catalog as the brief agent is told of it: its id, each
  /// component's schema and the functions.
  final JsonMap json,
) extends ChangeNotifier {
  var _query = '';
  CatalogOrigin? _origin;
  CatalogEntry? _openEntry;

  /// The id the catalog is registered under.
  String get catalogId => json.readString('catalogId');

  /// The search as typed, trimmed.
  String get query => _query;

  /// The origin shown; every origin when `null`.
  CatalogOrigin? get origin => _origin;

  /// The component opened in full, or `null`.
  CatalogEntry? get openEntry => _openEntry;

  /// The components of the origin shown whose names contain the search.
  List<CatalogEntry> get visibleEntries {
    final query = _query.toLowerCase();
    final origin = _origin;

    return entries
        .where(
          (entry) =>
              (origin == null || entry.origin == origin) &&
              entry.name.toLowerCase().contains(query),
        )
        .toList();
  }

  /// Reads [catalog]'s components and functions.
  factory of(Catalog catalog) {
    final basicNames = BasicCatalogItems.asCatalog().items
        .map((item) => item.name)
        .toSet();

    return CatalogBrowserController._(
      List.unmodifiable(
        catalog.items
            .map(
              (item) => CatalogEntry.fromItem(
                item,
                origin: basicNames.contains(item.name) ? .basic : .medical,
              ),
            )
            .sortedBy((entry) => entry.origin.index),
      ),
      List.unmodifiable(
        catalog.functions.map(CatalogFunctionEntry.fromFunction),
      ),
      catalog.toCapabilitiesJson(),
    );
  }

  /// How many components [origin] has; every one when `null`.
  int countOf(CatalogOrigin? origin) => origin == null
      ? entries.length
      : entries.where((entry) => entry.origin == origin).length;

  /// Narrows the components to the names containing [query].
  void search(String query) {
    _query = query.trim();
    notifyListeners();
  }

  /// Shows only [origin]'s components; every one when `null`.
  void filter(CatalogOrigin? origin) {
    _origin = origin;
    notifyListeners();
  }

  /// Opens [entry] in full, or closes it when it is open.
  void toggle(CatalogEntry entry) {
    _openEntry = entry == _openEntry ? null : entry;
    notifyListeners();
  }
}
