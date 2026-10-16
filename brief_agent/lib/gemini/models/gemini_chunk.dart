/// One server-sent event of a streamed reply.
class GeminiChunk {
  /// The chunk's text, thought summaries left out.
  final String text;

  /// Why the model stopped, on the last chunk; `null` before it.
  final String? finishReason;

  /// The token counts, on the chunks that report them.
  final Map<String, Object?>? usage;

  /// Creates a chunk.
  const GeminiChunk({required this.text, this.finishReason, this.usage});

  /// Reads a `GenerateContentResponse`, leaving out thought summaries.
  factory GeminiChunk.fromJson(Object? json) {
    if (json is! Map<String, Object?>) {
      throw FormatException('A reply chunk is not an object: $json');
    }
    final Map<String, Object?>? candidate = switch (json['candidates']) {
      [final Map<String, Object?> first, ...] => first,
      _ => null,
    };
    final Object? parts = switch (candidate?['content']) {
      final Map<String, Object?> content => content['parts'],
      _ => null,
    };

    return GeminiChunk(
      text: <String>[
        if (parts is List<Object?>)
          for (final Object? part in parts)
            if (part case final Map<String, Object?> map
                when map['thought'] != true)
              if (map['text'] case final String text) text,
      ].join(),
      finishReason: switch (candidate?['finishReason']) {
        final String reason => reason,
        _ => null,
      },
      usage: switch (json['usageMetadata']) {
        final Map<String, Object?> usage => usage,
        _ => null,
      },
    );
  }
}
