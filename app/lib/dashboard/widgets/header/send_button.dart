import 'package:flutter/material.dart';

/// The round button at the end of the field: an arrow, or a spinner while
/// the brief is being composed.
class const SendButton({
  super.key,

  /// Whether the brief is being composed; shows a spinner.
  required final bool isBusy,

  /// Sends the field's text; the button is disabled when `null`.
  required final VoidCallback? onPressed,
}) extends StatelessWidget {
  static const _size = 44.0;
  static const _iconSize = 22.0;
  static const _spinnerSize = 18.0;
  static const _spinnerStroke = 2.0;

  /// Creates Send Button
  this;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return IconButton.filled(
      tooltip: 'Refine the brief',
      onPressed: onPressed,
      style: IconButton.styleFrom(
        fixedSize: const .square(_size),
        backgroundColor: colors.onSurface,
        foregroundColor: colors.surface,
        disabledBackgroundColor: colors.surfaceContainerHighest,
        disabledForegroundColor: colors.onSurfaceVariant,
      ),
      icon: isBusy
          ? const SizedBox.square(
              dimension: _spinnerSize,
              child: CircularProgressIndicator(strokeWidth: _spinnerStroke),
            )
          : const Icon(Icons.arrow_forward_rounded, size: _iconSize),
    );
  }
}
