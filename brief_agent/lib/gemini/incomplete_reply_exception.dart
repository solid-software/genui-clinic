/// A reply that ended before the model said it was done.
class const IncompleteReplyException({
  /// The model that wrote the reply.
  required final String model,

  /// Why the model stopped, or `null` if the stream closed without saying.
  required final String? finishReason,

  /// How much of the reply arrived.
  required final int receivedCharacters,
}) implements Exception {
  /// Creates the exception.
  this;

  @override
  String toString() =>
      '$model reply ended unfinished after $receivedCharacters characters '
      '(finish reason: ${finishReason ?? 'none, the stream closed'}).';
}
