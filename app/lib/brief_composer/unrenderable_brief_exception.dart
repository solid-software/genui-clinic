/// Thrown when the brief the agent sent has nothing to draw.
class const UnrenderableBriefException() implements Exception {
  /// Creates the exception.
  this;

  @override
  String toString() => 'The agent sent no surface that has a root component.';
}
