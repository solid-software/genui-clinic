import 'package:clinical_brief/medical_catalog/models/lab_result.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// One flagged result: name and value on the left, status on the right.
class const LabResultRow({
  super.key,

  /// The result shown.
  required final LabResult result,
}) extends StatelessWidget {
  /// Name and value get the larger share; the status wraps in the rest.
  static const int _valueFlex = 3;
  static const int _statusFlex = 2;

  /// Creates the row.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color accent = result.tone.foregroundOf(context);
    final String? range = result.referenceRange;
    final String? history = result.history;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: result.tone.backgroundOf(context),
        borderRadius: BorderRadius.circular(AppSpacing.tileRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: _valueFlex,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      result.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      range == null
                          ? result.value
                          : '${result.value} \u00b7 $range',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: accent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                flex: _statusFlex,
                child: Text(
                  result.status,
                  textAlign: TextAlign.end,
                  style: theme.textTheme.bodyMedium?.copyWith(color: accent),
                ),
              ),
            ],
          ),
          if (history != null) ...<Widget>[
            const SizedBox(height: AppSpacing.xs),
            Text(
              history,
              style: theme.mutedBodySmall,
            ),
          ],
        ],
      ),
    );
  }
}
