import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/common/widgets/icon_tile.dart';
import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:clinical_brief/medical_catalog/models/care_gap.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// One item: a marker, what is outstanding, and when it was due.
class const CareGapRow({
  super.key,

  /// The item shown.
  required final CareGap gap,
}) extends StatelessWidget {
  static const double _markerSize = 36.0;

  /// Creates the row.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isNeutral = gap.tone == ClinicalTone.neutral;
    final Color accent = isNeutral
        ? theme.colorScheme.onSurface
        : gap.tone.foregroundOf(context);
    final Color tint = isNeutral
        ? theme.colorScheme.surfaceContainerHighest
        : gap.tone.backgroundOf(context);
    final String? status = gap.status;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: <Widget>[
          IconTile(
            icon: isNeutral ? Icons.schedule : Icons.error_outline,
            size: _markerSize,
            color: tint,
            foreground: accent,
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  gap.item,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (status != null) Text(status, style: theme.mutedBodyMedium),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Flexible: a long "due" must wrap, not push the row over.
          Flexible(
            child: PillChip(
              label: gap.due,
              color: tint,
              foreground: isNeutral
                  ? theme.colorScheme.onSurfaceVariant
                  : accent,
            ),
          ),
        ],
      ),
    );
  }
}
