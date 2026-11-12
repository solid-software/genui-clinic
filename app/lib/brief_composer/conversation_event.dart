import 'package:meta/meta.dart';

/// What a `BriefComposer` reports about its surfaces and the agent's
/// replies, as a stream the dashboard listens to.
@immutable
sealed class ConversationEvent {
  const ConversationEvent();
}

/// A surface drew its first frame: it has gained its root component.
final class ConversationSurfaceReady extends ConversationEvent {
  const ConversationSurfaceReady(this.surfaceId);

  /// The surface that is now renderable.
  final String surfaceId;
}

/// A surface was removed.
final class ConversationSurfaceRemoved extends ConversationEvent {
  const ConversationSurfaceRemoved(this.surfaceId);

  /// The surface that was removed.
  final String surfaceId;
}

/// The agent's reply, or something rendering it, reported an error.
final class ConversationError extends ConversationEvent {
  const ConversationError(this.error);

  /// The error, typically an `A2uiRendererError` from
  /// `package:a2ui_core`.
  final Object error;
}
