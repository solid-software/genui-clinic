/// A usage limit the brief agent enforces, by its name on the server.
enum BriefLimit(
  /// What to tell the user.
  final String message,
) {
  /// Daily limit exceeded.
  daily("You've used up today's briefs. Try again tomorrow."),

  /// Per minute limit exceeded.
  perMinute('Too many briefs in a minute. Try again shortly.'),
}
