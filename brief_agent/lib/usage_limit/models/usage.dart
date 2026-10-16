import 'package:google_cloud_firestore/google_cloud_firestore.dart';

/// One user's briefs, as `usage/{uid}` stores them: how many in a day and
/// how many in a minute, each with the period it counts.
class const Usage({
  /// The day [daily] counts, as `2026-10-14`.
  required final String day,

  /// Briefs asked for on [day].
  required final int daily,

  /// The minute [perMinute] counts, as `2026-10-14T09:30`.
  required final String minute,

  /// Briefs asked for in [minute].
  required final int perMinute,
}) {
  static const _day = 'day';
  static const _dayCount = 'dayCount';
  static const _minute = 'minute';
  static const _minuteCount = 'minuteCount';

  /// Creates a usage record.
  this;

  /// This usage as of [now]: a count from an earlier day or minute starts
  /// over at zero.
  Usage at(DateTime now) {
    final time = now.toUtc().toIso8601String();
    final today = time.substring(0, 10);
    final thisMinute = time.substring(0, 16);

    return .new(
      day: today,
      daily: day == today ? daily : 0,
      minute: thisMinute,
      perMinute: minute == thisMinute ? perMinute : 0,
    );
  }

  /// This usage with one more brief in both periods.
  Usage increment() => .new(
    day: day,
    daily: daily + 1,
    minute: minute,
    perMinute: perMinute + 1,
  );

  /// Reads the stored record; a user with none has used nothing.
  factory fromJson(DocumentData? json) => .new(
    day: json?[_day] as String? ?? '',
    daily: json?[_dayCount] as int? ?? 0,
    minute: json?[_minute] as String? ?? '',
    perMinute: json?[_minuteCount] as int? ?? 0,
  );

  /// The stored form.
  DocumentData toJson() => {
    _day: day,
    _dayCount: daily,
    _minute: minute,
    _minuteCount: perMinute,
  };
}
