/// What a brief section does when a new brief arrives.
enum MotionChange {
  /// Nothing yet: no brief came before this one.
  none,

  /// It glides from its place on the old brief.
  moved,

  /// It stays where it was and lifts in place.
  kept,

  /// It is new, and grows in with a "New" tag.
  entered,
}
