import 'dart:math' as math;

import 'package:genkit/genkit.dart';

/// Retry rules for model requests: models, timeouts and backoff.
class const ModelPolicy({
  /// Model names in the order attempts use them. Must not be empty.
  required final List<String> models,

  /// Longest silence tolerated from the model, thinking time included.
  required final Duration stallTimeout,

  /// Attempts per turn, the first one included.
  required final int maxAttempts,

  /// Wait before the second attempt; doubles for every attempt after that.
  required final Duration initialBackoff,
}) {
  /// The policy the agent runs with.
  ///
  /// Each retry switches model, since "high demand" is reported per model.
  static const standard = ModelPolicy(
    models: ['gemini-3.8-flash', 'gemini-3.5-flash', 'gemini-3.5-flash-lite'],
    // A first chunk takes up to about 9 s, thinking included.
    stallTimeout: .new(seconds: 20),
    maxAttempts: 3,
    initialBackoff: .new(seconds: 2),
  );

  static const _backoffBase = 2;
  static const _firstRetryAttempt = 2;

  /// Statuses another attempt can get past: overload, a gateway timeout, or
  /// a model this location does not serve, which the next model may.
  ///
  /// Genkit reports HTTP codes it has no status for, such as 408 and 502,
  /// and transport errors as [StatusCode.internal].
  static const _transientStatuses = <StatusCode>{
    .notFound,
    .resourceExhausted,
    .internal,
    .unavailable,
    .deadlineExceeded,
  };

  /// Creates a policy.
  this : assert(maxAttempts > 0, 'At least one attempt is required.');

  /// The model that serves [attempt], counted from 1.
  String modelFor(int attempt) => models[(attempt - 1) % models.length];

  /// How long to wait before [attempt], counted from 1.
  Duration backoffBefore(int attempt) => attempt < _firstRetryAttempt
      ? .zero
      : initialBackoff * math.pow(_backoffBase, attempt - _firstRetryAttempt);

  /// Whether [error], raised by [attempt], deserves another attempt.
  bool canRetry(Object error, {required int attempt}) =>
      attempt < maxAttempts && isTransient(error);

  /// Whether [error] can go away on its own, unlike a refused request or a
  /// missing permission.
  static bool isTransient(Object error) => switch (error) {
    GenkitException(:final status) => _transientStatuses.contains(status),
    _ => true,
  };
}
