import 'package:clinical_brief/medical_catalog/models/imaging_event.dart';
import 'package:clinical_brief/medical_catalog/widgets/imaging/imaging_film.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Date, study and what it showed.
class const ImagingEventText({
  super.key,

  /// The study shown.
  required final ImagingEvent event,
}) extends StatelessWidget {
  static const double _thumbnailHeight = 110.0;

  /// Creates the text.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? image = event.image;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          event.date,
          style: theme.mutedBodySmall,
        ),
        Text(
          event.modality,
          style: theme.textTheme.titleSmall?.copyWith(
            color: event.tone.accentOf(context),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(event.conclusion, style: theme.textTheme.bodyMedium),
        if (image != null) ...<Widget>[
          const SizedBox(height: AppSpacing.sm),
          ImagingFilm(image: image, height: _thumbnailHeight),
        ],
      ],
    );
  }
}
