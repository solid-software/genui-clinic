import 'package:clinical_brief/common/widgets/retry_button.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Why something failed, with a button to try again.
class ErrorMessage extends StatelessWidget {
  /// What went wrong, in a sentence.
  final String message;

  /// Called by the button; the button is disabled when `null`.
  final VoidCallback? onRetry;

  /// Until when the button counts down instead of offering a retry, or
  /// `null` for no countdown.
  final DateTime? retryAt;

  final bool _isBanner;

  /// The message on its own, centred, for a screen with nothing else to
  /// show.
  const ErrorMessage.centered({
    super.key,
    required this.message,
    required this.onRetry,
    this.retryAt,
  }) : _isBanner = false;

  /// A rose card with an icon, above the content the failure concerns.
  const ErrorMessage.banner({
    super.key,
    required this.message,
    required this.onRetry,
    this.retryAt,
  }) : _isBanner = true;

  @override
  Widget build(BuildContext context) {
    final retry = RetryButton(onRetry: onRetry, retryAt: retryAt);
    if (!_isBanner) {
      return Center(
        child: Column(
          mainAxisSize: .min,
          spacing: AppSpacing.md,
          children: [
            Text(message),
            if (onRetry != null) retry,
          ],
        ),
      );
    }

    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.cardGap),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Row(
        spacing: AppSpacing.md,
        children: [
          Icon(Icons.error_outline, color: theme.colorScheme.onErrorContainer),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
          if (onRetry != null) retry,
        ],
      ),
    );
  }
}
