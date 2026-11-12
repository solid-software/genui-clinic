import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:flutter/widgets.dart';

/// The resolved node a medical catalog item's builder reads from, and
/// builds its widget with.
class ItemContext {
  /// Creates an item context for one resolved [node].
  const ItemContext(this.context, this.node, this.props, this.buildChild);

  /// The build context the component is drawn in.
  final BuildContext context;

  /// The resolved node this component draws.
  final ComponentNode<ComponentImplementation> node;

  /// The node's resolved properties.
  final ComponentProps props;

  /// Builds the widget for one child node.
  final ChildWidgetBuilder buildChild;

  /// The component's declared type, e.g. `TrendChart`.
  String get type => node.type;

  /// The component's literal properties, resolved and unwrapped, excluding
  /// child references, which resolve to [ComponentNode]s rather than JSON.
  Map<String, Object?> get data => {
    for (final String key in props.keys)
      if (!_isChildRef(props.value(key))) key: props.value(key),
  };

  static bool _isChildRef(Object? value) => switch (value) {
    ComponentNode<ComponentImplementation>() => true,
    final List<Object?> items => items.any(
      (item) => item is ComponentNode<ComponentImplementation>,
    ),
    _ => false,
  };
}
