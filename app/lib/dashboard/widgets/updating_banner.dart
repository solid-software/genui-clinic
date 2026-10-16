import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// A slim notice above a brief that is being replaced.
class const UpdatingBanner({
  super.key,

  /// What the brief is being updated around.
  required final String detail,
}) extends StatelessWidget {
  static const double _barHeight = 4.0;

  /// Creates the banner.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.cardGap),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.tileRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            detail,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(_barHeight),
            child: const LinearProgressIndicator(minHeight: _barHeight),
          ),
        ],
      ),
    );
  }
}
