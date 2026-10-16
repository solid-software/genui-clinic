import 'package:clinical_brief/brief_composer/models/brief_limit.dart';

/// The brief agent turned a request down: the user reached [limit], or a
/// limit this app does not know yet when `null`.
class const BriefLimitException({
  /// How long until the limit lifts, if the agent said.
  required final Duration retryAfter,

  /// The limit reached.
  final BriefLimit? limit,
}) implements Exception {
  /// Creates the exception.
  this;

  /// What to tell the user.
  String get message =>
      limit?.message ?? 'Brief limit reached. Try again later.';

  /// Reads the `details` the agent sends with a refusal: a list whose first
  /// entry names the limit and the seconds until it lifts. Anything missing
  /// or unknown is left `null`.
  factory fromDetails(Object? details) {
    final json = switch (details) {
      [final Map<Object?, Object?> json, ...] => json,
      _ => const <Object?, Object?>{},
    };

    return .new(
      limit: switch (json['limit']) {
        final String name => BriefLimit.values.asNameMap()[name],
        _ => null,
      },
      retryAfter: switch (json['retryAfterSeconds']) {
        // A double on web, where the number comes through JavaScript.
        final num seconds => Duration(seconds: seconds.ceil()),
        _ => const Duration(minutes: 1),
      },
    );
  }

  @override
  String toString() => message;
}
