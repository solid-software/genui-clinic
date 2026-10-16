import 'package:clinical_brief/medical_catalog/models/imaging_event.dart';
import 'package:clinical_brief/medical_catalog/widgets/imaging/imaging_event_text.dart';
import 'package:clinical_brief/medical_catalog/widgets/imaging/timeline_dot.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// The same studies stacked, for a narrow screen or a long list.
class const VerticalImagingTimeline({
  super.key,

  /// The studies, oldest first.
  required final List<ImagingEvent> events,

  /// What has happened since the last study, or `null`.
  required final String? sinceNote,
}) extends StatelessWidget {
  static const double _railWidth = 2.0;
  static const double _railInset = 4.5;

  /// Creates the timeline.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? note = sinceNote;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final ImagingEvent event in events)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TimelineDot(color: event.tone.accentOf(context)),
                    Expanded(
                      child: Container(
                        width: _railWidth,
                        margin: const EdgeInsets.only(left: _railInset),
                        color: theme.colorScheme.outlineVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                    child: ImagingEventText(event: event),
                  ),
                ),
              ],
            ),
          ),
        if (note != null)
          Text(
            note,
            style: theme.mutedBodyMedium,
          ),
      ],
    );
  }
}
