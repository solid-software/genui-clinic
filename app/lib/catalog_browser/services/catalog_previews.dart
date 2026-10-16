import 'dart:convert';

import 'package:a2ui_core/a2ui_core.dart' as core;
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:collection/collection.dart';
import 'package:genui/genui.dart';

/// Draws each catalog component from its first example, on a surface named
/// after the component.
class CatalogPreviews._(
  final SurfaceController _controller,
  final Map<String, List<JsonMap>> _components,
) {
  /// The component GenUI draws a surface from.
  static const _rootId = 'root';

  /// A2UI's type for a list of child ids.
  static const _childListType = r'/$defs/ChildList';

  /// Sends each example in [catalog] to a surface of its own.
  ///
  /// An example without a `root` gets its own component as the root, and
  /// the children it lists but lacks from the examples that define them.
  factory of(Catalog catalog) {
    final catalogId = ArgumentError.checkNotNull(
      catalog.catalogId,
      'catalog.catalogId',
    );
    final examples = {
      for (final item in catalog.items)
        if (item.exampleData.firstOrNull case final example?)
          item.name: (jsonDecode(example()) as List<Object?>)
              .whereType<JsonMap>()
              .toList(),
    };
    final childLists = {
      for (final item in catalog.items) item.name: _childListKeysOf(item),
    };
    final components = {
      for (final MapEntry(key: name, value: example) in examples.entries)
        name: _withChildren(
          _rooted(name, example),
          examples.values,
          childLists,
        ),
    };
    final controller = SurfaceController(catalogs: [catalog]);
    for (final MapEntry(key: name, value: surface) in components.entries) {
      controller
        ..handleMessage(
          core.CreateSurfaceMessage(surfaceId: name, catalogId: catalogId),
        )
        ..handleMessage(
          core.UpdateComponentsMessage(surfaceId: name, components: surface),
        );
    }

    return CatalogPreviews._(controller, components);
  }

  /// The surface drawing [name]'s example.
  SurfaceContext surfaceOf(String name) => _controller.contextFor(name);

  /// The components [name]'s surface was sent, as A2UI JSON.
  List<JsonMap> componentsOf(String name) => _components[name] ?? const [];

  /// Releases the surfaces.
  void dispose() => _controller.dispose();

  /// The properties of [item] that list child ids as A2UI's `ChildList`.
  static List<String> _childListKeysOf(CatalogItem item) {
    final properties = item.dataSchema.value.readObject('properties');

    return properties.keys
        .where(
          (key) => properties
              .readObject(key)
              .readString(r'$ref')
              .endsWith(_childListType),
        )
        .toList();
  }

  /// [components] with [name]'s own component as the root, unless one of
  /// them already is.
  static List<JsonMap> _rooted(String name, List<JsonMap> components) {
    if (components.map(_idOf).contains(_rootId)) return components;

    final own = components.firstWhereOrNull(
      (component) => component['component'] == name,
    );

    return components
        .map((c) => {...c, if (identical(c, own)) 'id': _rootId})
        .toList();
  }

  /// [components] with the children they list but lack: each comes with the
  /// rest of the first of [examples] that defines it, and so on for the
  /// children those list.
  ///
  /// [childLists] holds each component type's child-list properties.
  static List<JsonMap> _withChildren(
    List<JsonMap> components,
    Iterable<List<JsonMap>> examples,
    Map<String, List<String>> childLists,
  ) {
    final ids = components.map(_idOf).toSet();
    final missing = {
      for (final component in components)
        ...?childLists[component['component']]?.expand(
          component.readStringList,
        ),
    }.difference(ids);
    final source = examples.firstWhereOrNull(
      (example) => example.map(_idOf).any(missing.contains),
    );

    return source == null
        ? components
        : _withChildren(
            [
              ...components,
              ...source.where((component) => !ids.contains(_idOf(component))),
            ],
            examples,
            childLists,
          );
  }

  static String _idOf(JsonMap component) => component.readString('id');
}
