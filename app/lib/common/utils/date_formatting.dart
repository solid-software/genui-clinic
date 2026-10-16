import 'package:intl/intl.dart';

/// How dates read in the UI.
abstract final class DateFormatting {
  /// Month and year, e.g. `Mar 2025`.
  static String monthYear(DateTime date) => DateFormat.yMMM().format(date);
}
