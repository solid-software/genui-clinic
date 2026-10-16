/// A reply that is not exactly one brief.
///
/// Its [message] is sent back to the model, so it must be actionable.
class const BriefRejectedException({
  /// What is wrong.
  required final String message,
}) implements Exception {
  /// Creates the exception.
  this;

  @override
  String toString() => 'BriefRejectedException: $message';
}
