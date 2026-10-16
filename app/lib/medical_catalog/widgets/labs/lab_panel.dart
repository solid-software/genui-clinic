import 'package:clinical_brief/common/widgets/icon_tile.dart';
import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:clinical_brief/medical_catalog/models/lab_result.dart';
import 'package:clinical_brief/medical_catalog/widgets/labs/lab_result_row.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// One day's lab panel: flagged results in full, the rest as a summary.
class const LabPanel({
  super.key,

  /// The panel name, e.g. `Blood panel`.
  required final String title,

  /// The results worth reading, normally the ones out of range.
  required final List<LabResult> flagged,

  /// Where and when it was taken, e.g. `Valley Clinic - Feb 2026`.
  final String? source,

  /// How the rest came back, e.g. `7 other markers within range`.
  final String? normalSummary,
}) extends StatelessWidget {
  /// Creates a lab panel.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? taken = source;
    final String? normal = normalSummary;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.cardGap),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const IconTile(icon: Icons.science_outlined),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: theme.textTheme.titleLarge),
                    if (taken != null)
                      Text(taken, style: theme.mutedBodyMedium),
                  ],
                ),
              ),
              if (flagged.isNotEmpty)
                PillChip.badge(
                  label: '${flagged.length} flagged',
                  color: flagged.first.tone.backgroundOf(context),
                  foreground: flagged.first.tone.foregroundOf(context),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          for (final LabResult result in flagged)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: LabResultRow(result: result),
            ),
          if (normal != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppSpacing.tileRadius),
              ),
              child: Text(
                normal,
                textAlign: TextAlign.center,
                style: theme.mutedBodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}
