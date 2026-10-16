import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/medical_catalog/widgets/imaging/imaging_film.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// One entry: label and detail on the left, date or value on the right.
class const RecordRow({
  super.key,

  /// What the entry is.
  required final String label,

  /// Optional muted line under the label.
  final String? detail,

  /// Optional asset path of an image shown under the label.
  final String? image,

  /// Optional date or value on the right.
  final String? trailing,

  /// How much attention [trailing] should draw.
  final ClinicalTone trailingTone = .neutral,

  /// Whether [trailing] is a reading, set larger and bolder.
  final bool emphasiseTrailing = false,
}) extends StatelessWidget {
  static const _detailGap = 2.0;
  static const _thumbnailHeight = 96.0;

  /// Creates a record row
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final detail = this.detail;
    final trailing = this.trailing;
    final image = this.image;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(label, style: theme.textTheme.bodyMedium),
                if (detail != null && detail.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: _detailGap),
                    child: Text(
                      detail,
                      style: theme.mutedBodySmall,
                    ),
                  ),
                if (image != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: ImagingFilm(image: image, height: _thumbnailHeight),
                  ),
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.md),
            Flexible(
              child: Text(
                trailing,
                textAlign: .end,
                style: _trailingStyle(context),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Tabular figures so readings line up; flagged values take the tone colour.
  TextStyle? _trailingStyle(BuildContext context) {
    final theme = Theme.of(context);
    final isFlagged = trailingTone != .neutral;
    final base = emphasiseTrailing
        ? theme.textTheme.bodyLarge
        : theme.textTheme.bodySmall;
    final color = isFlagged
        ? trailingTone.foregroundOf(context)
        : emphasiseTrailing
        ? theme.colorScheme.onSurface
        : theme.colorScheme.onSurfaceVariant;

    return base?.copyWith(
      color: color,
      fontWeight: emphasiseTrailing || isFlagged ? .w600 : null,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }
}
