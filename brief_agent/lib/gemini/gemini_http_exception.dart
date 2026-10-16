/// Gemini answered a request with an HTTP error.
class const GeminiHttpException({
  /// The model the request went to.
  required final String model,

  /// The HTTP status code.
  required final int statusCode,

  /// The response body, usually a JSON `error` object.
  required final String body,
}) implements Exception {
  /// Creates the exception.
  this;

  @override
  String toString() => '$model answered $statusCode: $body';
}
