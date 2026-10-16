import 'package:intl/intl.dart';

/// How numbers read in the UI.
abstract final class NumberFormatting {
  /// Shown in place of NaN or infinity, which no reading can be.
  static const _notANumber = '—';

  /// At most one decimal, no trailing zero and no grouping.
  static final _compact = NumberFormat('###0.#');

  /// `118.0` as `118`, `3.6` as `3.6`, `4.01` as `4`; NaN or infinity as `—`.
  static String compact(num value) =>
      value.isFinite ? _compact.format(value) : _notANumber;
}
