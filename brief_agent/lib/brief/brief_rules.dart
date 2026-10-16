import 'package:a2ui_agent/a2ui_agent.dart';
import 'package:a2ui_core/a2ui_core.dart';
import 'package:brief_agent/brief/brief_rejected_exception.dart';

/// What a brief may be: one new surface with its components, nothing else.
abstract final class BriefRules {
  /// The message types a brief is made of; the prompt teaches only these.
  static const messageTypes = ['createSurface', 'updateComponents'];

  /// The messages of the one brief in [parts], moved to [surfaceId].
  ///
  /// Every brief is a new surface, so the app can tell it from an update and
  /// move the cards across. Throws [BriefRejectedException] unless [parts]
  /// hold exactly one brief.
  static List<AgentToRendererMessage> briefIn(
    List<ResponsePart> parts, {
    required String surfaceId,
  }) {
    final messages = parts
        .whereType<A2uiPart>()
        .expand((part) => part.a2ui)
        .toList();
    if (messages.isEmpty) {
      throw const BriefRejectedException(
        message:
            'The reply has no <a2ui> block. Write the whole brief inside '
            '<a2ui> and </a2ui>.',
      );
    }
    final surfaces = messages.whereType<CreateSurfaceMessage>().length;
    if (surfaces == 0) {
      // A block without root updates an earlier surface; a brief needs its own.
      throw const BriefRejectedException(
        message:
            'The block creates no brief. Assign the top component to root, '
            'e.g. root = Column(children=[...]).',
      );
    }
    if (surfaces > 1 || !messages.every(_belongsToBrief)) {
      throw const BriefRejectedException(
        message:
            'A brief is one new surface: assign root and its components, with at '
            r'most one surface(...) line and no deleteSurface(...) or $ paths.',
      );
    }
    if (messages.whereType<UpdateComponentsMessage>().any(_bindsData)) {
      throw const BriefRejectedException(
        message:
            r'Data bindings ($/...) have no data to read here; write the values '
            'themselves.',
      );
    }
    return [for (final message in messages) _onSurface(message, surfaceId)];
  }

  static bool _belongsToBrief(AgentToRendererMessage message) =>
      message is CreateSurfaceMessage || message is UpdateComponentsMessage;

  static bool _bindsData(UpdateComponentsMessage message) =>
      _hasBinding(message.components);

  /// Whether [value] holds a data binding, or a child list bound to data.
  static bool _hasBinding(Object? value) => switch (value) {
    final Map<Object?, Object?> map
        when map['path'] is String &&
            (map.length == 1 || map.containsKey('componentId')) =>
      true,
    final Map<Object?, Object?> map => map.values.any(_hasBinding),
    final List<Object?> list => list.any(_hasBinding),
    _ => false,
  };

  static AgentToRendererMessage _onSurface(
    AgentToRendererMessage message,
    String surfaceId,
  ) => switch (message) {
    final CreateSurfaceMessage create => CreateSurfaceMessage(
      version: create.version,
      surfaceId: surfaceId,
      catalogId: create.catalogId,
      theme: create.theme,
      sendDataModel: create.sendDataModel,
    ),
    final UpdateComponentsMessage update => UpdateComponentsMessage(
      version: update.version,
      surfaceId: surfaceId,
      components: update.components,
    ),
    _ => message,
  };
}
