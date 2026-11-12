import 'dart:convert';

import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:clinical_brief/common/utils/json_reader.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
import 'package:collection/collection.dart';

/// Draws each catalog component from its first example, on a surface named
/// after the component.
class CatalogPreviews._(
  final MessageProcessor<ComponentImplementation> _processor,
  final Map<String, List<Map<String, Object?>>> _components,
) {
  /// The wire version every preview surface is created as.
  static final String _version = A2uiProtocolVersion.v1_0.jsonValue;

  /// The component A2UI draws a surface's tree from.
  static const _rootId = 'root';

  /// A2UI's reference type for a list of child ids.
  static const _childListType = r'/$defs/ChildList';

  /// Fires when a preview dispatches an action; the catalog page has no
  /// agent to send it to.
  EventSource<A2uiRendererAction> get onAction => _processor.model.onAction;

  /// Sends each example in [catalog] to a surface of its own.
  ///
  /// An example without a `root` gets its own component as the root, and
  /// the children it lists but lacks from the examples that define them.
  /// A component with no example of its own (a kept basic component, say)
  /// gets no surface; [surfaceOf] gives `null` for it.
  factory of(CatalogImplementation catalog) {
    final examples = {
      for (final item in catalog.components.values)
        if (CatalogItemFactory.examples[item.name] case final example?)
          item.name: (jsonDecode(example) as List<Object?>)
              .whereType<Map<String, Object?>>()
              .toList(),
    };
    final childLists = {
      for (final item in catalog.components.values)
        item.name: _childListKeysOf(item),
    };
    final components = {
      for (final MapEntry(key: name, value: example) in examples.entries)
        name: _withChildren(
          _rooted(name, example),
          examples.values,
          childLists,
        ),
    };
    final processor = MessageProcessor<ComponentImplementation>(
      catalogs: [catalog],
      validationConfig: ValidationConfig.relaxed,
      reportErrorsOnly: true,
    );
    for (final MapEntry(key: name, value: surface) in components.entries) {
      processor.processMessages([
        {
          'version': _version,
          'createSurface': {'surfaceId': name, 'catalogId': catalog.id},
        },
        {
          'version': _version,
          'updateComponents': {'surfaceId': name, 'components': surface},
        },
      ]);
    }

    return CatalogPreviews._(processor, components);
  }

  /// The surface drawing [name]'s example, or `null` without one.
  SurfaceModel<ComponentImplementation>? surfaceOf(String name) =>
      _processor.model.getSurface(name);

  /// The components [name]'s surface was sent, as A2UI JSON.
  List<Map<String, Object?>> componentsOf(String name) =>
      _components[name] ?? const [];

  /// Releases the surfaces.
  void dispose() => _processor.dispose();

  /// The properties of [item] that list child ids as A2UI's `ChildList`.
  static List<String> _childListKeysOf(ComponentImplementation item) {
    final properties = item.schema.value.readObject('properties');

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
  static List<Map<String, Object?>> _rooted(
    String name,
    List<Map<String, Object?>> components,
  ) {
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
  static List<Map<String, Object?>> _withChildren(
    List<Map<String, Object?>> components,
    Iterable<List<Map<String, Object?>>> examples,
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

  static String _idOf(Map<String, Object?> component) =>
      component.readString('id');
}
