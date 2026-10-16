import 'dart:async';
import 'dart:io';

import 'package:brief_agent/gemini/incomplete_reply_exception.dart';
import 'package:brief_agent/gemini/model_policy.dart';
import 'package:brief_agent/gemini/models/gemini_content.dart';
import 'package:firebase_functions/logger.dart' as logger;
import 'package:genkit/genkit.dart';
import 'package:genkit_vertexai/genkit_vertexai.dart';

/// Gemini on Vertex AI through Genkit, called as the function's service
/// account: whole replies, read as they stream so a stalled one is cut early.
class GeminiClient {
  /// The global endpoint serves every Gemini model, previews included.
  static const _location = 'global';

  /// What the Firebase CLI sets to the project a function runs in.
  static const _projectVariables = ['GCLOUD_PROJECT', 'GOOGLE_CLOUD_PROJECT'];

  static final _options = GeminiOptions(
    // Low, so the same record and complaint rank the same way twice in a row.
    temperature: 0.2,
    // Cap on one reply, so a looping generation ends; a brief needs far less.
    maxOutputTokens: 32768,
    // About 2 s of thinking, so a brief starts within seconds. A level lets
    // the model decide how long to think; a budget sets a limit.
    thinkingConfig: .new(thinkingBudget: 256),
  );

  final Genkit _ai;
  final ModelPolicy _policy;

  /// Creates a client for the project in [projectId].
  GeminiClient({required String projectId, ModelPolicy? policy})
    : _policy = policy ?? .standard,
      // No authClient: the plugin then closes a request's connection when it
      // is cancelled, which is what cuts a stalled one.
      _ai = .new(
        plugins: [vertexAI(projectId: projectId, location: _location)],
        promptDir: null,
      );

  /// Creates a client for the project the function runs in.
  ///
  /// Throws [StateError] outside the Firebase CLI and Cloud Run, where no
  /// project is set.
  factory forThisProject() => GeminiClient(
    projectId:
        _projectVariables
            .map((name) => Platform.environment[name])
            .nonNulls
            .firstOrNull ??
        (throw StateError('Set GCLOUD_PROJECT to the Firebase project id.')),
  );

  /// Returns one complete reply, moving on to the next model after a failure.
  Future<String> reply({
    required String systemInstruction,
    required List<GeminiContent> contents,
  }) async {
    final messages = [for (final content in contents) content.toMessage()];
    for (var attempt = 1; ; attempt++) {
      await Future.delayed(_policy.backoffBefore(attempt));

      final model = _policy.modelFor(attempt);
      logger.info(
        'Requesting $model, attempt $attempt of ${_policy.maxAttempts}.',
      );
      try {
        return await _attempt(model, systemInstruction, messages);
      } on Exception catch (error) {
        if (!_policy.canRetry(error, attempt: attempt)) {
          rethrow;
        }
        logger.warning(
          '$model failed on attempt $attempt of ${_policy.maxAttempts}; '
          'trying ${_policy.modelFor(attempt + 1)}.',
          <String, Object?>{'error': '$error'},
        );
      }
    }
  }

  /// One request to [model]; throws unless the model says it finished.
  ///
  /// A watchdog cancels the request when no chunk arrives within the stall
  /// timeout, so a stalled request stops before the next model starts.
  Future<String> _attempt(
    String model,
    String systemInstruction,
    List<Message> messages,
  ) async {
    final clock = Stopwatch()..start();
    final stall = CancellationController();
    var watchdog = Timer(_policy.stallTimeout, stall.cancel);
    Duration? firstChunk;

    final GenerateResult<Object?> result;
    try {
      result = await _ai.generate(
        model: vertexAI.gemini(model),
        system: systemInstruction,
        messages: messages,
        config: _options,
        cancel: stall.token,
        // Asking for chunks is also what makes the plugin stream.
        onChunk: (_) {
          firstChunk ??= clock.elapsed;
          watchdog.cancel();
          watchdog = .new(_policy.stallTimeout, stall.cancel);
        },
      );
    } finally {
      watchdog.cancel();
    }

    // Genkit resolves a failed or cancelled call rather than throwing.
    if (stall.isCancelled) {
      throw TimeoutException('$model stalled.', _policy.stallTimeout);
    }

    switch (result.finishReason) {
      case .failed:
        throw result.cause ?? Exception(result.finishMessage);
      case != .stop:
        throw IncompleteReplyException(
          model: model,
          finishReason: result.finishReason.value,
          receivedCharacters: result.text.length,
        );
    }

    final usage = result.usage;
    logger.info(
      '$model replied in ${clock.elapsedMilliseconds} ms, first chunk after '
      '${(firstChunk ?? clock.elapsed).inMilliseconds} ms: '
      '${usage?.outputTokens ?? '?'} output tokens, '
      '${usage?.thoughtsTokens ?? 0} thinking tokens, '
      '${usage?.inputTokens ?? '?'} prompt tokens, '
      '${usage?.totalTokens ?? '?'} total tokens, '
      '${result.text.length} characters.',
      <String, Object?>{'model': model, 'usage': usage?.toJson()},
    );

    return result.text;
  }
}
