import 'package:clinical_brief/medical_catalog/models/imaging_event.dart';
import 'package:clinical_brief/medical_catalog/widgets/imaging/imaging_event_text.dart';
import 'package:clinical_brief/medical_catalog/widgets/imaging/timeline_dot.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Dates along a line, with each study under its dot.
class const HorizontalImagingTimeline({
  super.key,

  /// The studies, oldest first.
  required final List<ImagingEvent> events,

  /// What has happened since the last study, or `null`.
  required final String? sinceNote,
}) extends StatelessWidget {
  static const double _lineHeight = 2.0;

  /// Creates the timeline.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? note = sinceNote;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            for (final ImagingEvent event in events)
              Expanded(
                child: Row(
                  children: <Widget>[
                    TimelineDot(color: event.tone.accentOf(context)),
                    Expanded(
                      child: Container(
                        height: _lineHeight,
                        color: theme.colorScheme.outlineVariant,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final ImagingEvent event in events)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: ImagingEventText(event: event),
                ),
              ),
          ],
        ),
        if (note != null) ...<Widget>[
          const SizedBox(height: AppSpacing.md),
          Text(
            note,
            style: theme.mutedBodyMedium,
          ),
        ],
      ],
    );
  }
}
