import 'dart:developer' as developer;

import 'package:logging/logging.dart';

/// The app's loggers, all named under `clinical_brief`.
abstract final class AppLogger {
  static const _rootName = 'clinical_brief';

  /// Sends log records to the developer console. Call once, from `main`.
  static void configure({Level level = .INFO}) => Logger.root
    ..level = level
    ..onRecord.listen(
      (record) => developer.log(
        record.message,
        name: record.loggerName,
        level: record.level.value,
        time: record.time,
        error: record.error,
        stackTrace: record.stackTrace,
      ),
    );

  /// The logger named `clinical_brief.[name]`.
  static Logger of(String name) => .new('$_rootName.$name');
}
