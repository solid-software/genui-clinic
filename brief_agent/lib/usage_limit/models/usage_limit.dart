import 'package:brief_agent/usage_limit/models/usage.dart';
import 'package:firebase_functions/firebase_functions.dart';

/// A usage limit per unit of time.
enum const UsageLimit({
  /// The error message thrown if usage exceeds the limit.
  required final String message,

  /// The value of calls allowed per unit of time.
  required final int limit,
}) {
  daily(message: "You've used today's briefs. Try again tomorrow.", limit: 50),
  perMinute(
    message: 'Too many briefs in a minute. Try again shortly.',
    limit: 5,
  );

  void admit(Usage usage, DateTime now) =>
      _usedIn(usage) >= limit ? _refuse(now) : null;

  int _usedIn(Usage usage) => switch (this) {
    daily => usage.daily,
    perMinute => usage.perMinute,
  };

  Duration _remainingAt(DateTime now) {
    final utc = now.toUtc();
    final end = switch (this) {
      daily => DateTime.utc(utc.year, utc.month, utc.day + 1),
      perMinute => DateTime.utc(
        utc.year,
        utc.month,
        utc.day,
        utc.hour,
        utc.minute + 1,
      ),
    };

    return end.difference(utc);
  }

  Never _refuse(DateTime now) => throw HttpResponseException.tooManyRequests(
    message: message,
    details: [
      {
        'limit': name,
        'retryAfterSeconds': (_remainingAt(now).inMilliseconds / 1000).ceil(),
      },
    ],
  );
}
