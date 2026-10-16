import 'dart:async';

import 'package:flutter/material.dart';

/// "Try again", or a countdown to [retryAt] while it lies ahead.
///
/// Ticks on its own, so only the button rebuilds each second.
class const RetryButton({
  required final VoidCallback? onRetry,
  required final DateTime? retryAt,
}) extends StatefulWidget {
  /// Constructor.
  this;
  @override
  State<RetryButton> createState() => _RetryButtonState();
}

class _RetryButtonState extends State<RetryButton> {
  static const _tick = Duration(seconds: 1);

  Timer? _ticker;

  /// Whole seconds until [RetryButton.retryAt], rounded up; 0 once passed.

  int get _secondsLeft {
    final retryAt = widget.retryAt;
    if (retryAt == null) return 0;

    final left = retryAt.difference(DateTime.now()).inMilliseconds;

    return left <= 0 ? 0 : (left / _tick.inMilliseconds).ceil();
  }

  @override
  void initState() {
    super.initState();
    _startTicking();
  }

  @override
  Widget build(BuildContext context) {
    final seconds = _secondsLeft;

    return FilledButton(
      onPressed: seconds > 0 ? null : widget.onRetry,
      child: Text(seconds > 0 ? 'Try again in $seconds s' : 'Try again'),
    );
  }

  @override
  void didUpdateWidget(RetryButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.retryAt != oldWidget.retryAt) {
      _startTicking();
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _startTicking() {
    _ticker?.cancel();
    _ticker = _secondsLeft > 0
        ? Timer.periodic(_tick, (_) {
            if (_secondsLeft == 0) _ticker?.cancel();
            setState(() => ());
          })
        : null;
  }
}
