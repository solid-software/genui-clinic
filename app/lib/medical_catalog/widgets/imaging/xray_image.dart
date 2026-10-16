import 'package:clinical_brief/medical_catalog/widgets/imaging/imaging_film.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// A radiograph or CT slice on black, with its report, enlarged on tap.
class const XRayImage({
  super.key,

  /// Asset path of the image, as given in the record.
  required final String image,

  /// What it showed, in the words of the report.
  required final String conclusion,

  /// When it was taken, e.g. `Nov 2021`.
  required final String date,
}) extends StatelessWidget {
  static const double _imageHeight = 240.0;

  /// Creates an X-ray image.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? credit = ImagingFilm.creditFor(image);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ImagingFilm(image: image, height: _imageHeight),
        const SizedBox(height: AppSpacing.sm),
        Text('$date \u00b7 $conclusion', style: theme.textTheme.bodyMedium),
        Text(
          credit == null ? 'Tap to enlarge' : '$credit \u00b7 tap to enlarge',
          style: theme.mutedBodySmall,
        ),
      ],
    );
  }
}
