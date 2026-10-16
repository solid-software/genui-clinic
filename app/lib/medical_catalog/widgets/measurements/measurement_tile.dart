import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/medical_catalog/models/measurement.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// One of today's readings in large type, tinted by its tone.
class const MeasurementTile({
  super.key,

  /// The reading shown.
  required final Measurement measurement,
}) extends StatelessWidget {
  static const double _radius = 20.0;
  static const double _padding = 20.0;

  /// Creates the tile.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isNeutral = measurement.tone == ClinicalTone.neutral;
    final Color accent = isNeutral
        ? theme.colorScheme.onSurface
        : measurement.tone.foregroundOf(context);
    final String? meta = measurement.meta;

    return Container(
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: measurement.tone.backgroundOf(context),
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            measurement.label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isNeutral ? theme.colorScheme.onSurfaceVariant : accent,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            measurement.value,
            style: theme.textTheme.headlineMedium?.copyWith(color: accent),
          ),
          if (meta != null) ...<Widget>[
            const SizedBox(height: AppSpacing.xs),
            Text(
              meta,
              style: theme.mutedBodySmall,
            ),
          ],
        ],
      ),
    );
  }
}
