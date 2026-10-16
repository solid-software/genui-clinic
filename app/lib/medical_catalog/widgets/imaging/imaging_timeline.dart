import 'package:clinical_brief/medical_catalog/models/imaging_event.dart';
import 'package:clinical_brief/medical_catalog/widgets/imaging/horizontal_imaging_timeline.dart';
import 'package:clinical_brief/medical_catalog/widgets/imaging/vertical_imaging_timeline.dart';
import 'package:flutter/material.dart';

/// Scans and studies on a time line, oldest first.
class const ImagingTimeline({
  super.key,

  /// The studies, oldest first.
  required final List<ImagingEvent> events,

  /// What has happened since the last study, e.g. `Nothing since 2021`.
  final String? sinceNote,
}) extends StatelessWidget {
  static const _horizontalMinWidth = 560.0;
  static const _maxHorizontalEvents = 5;

  /// Creates imaging timeline.
  this;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (_, constraints) =>
        (constraints.maxWidth >= _horizontalMinWidth &&
            events.length <= _maxHorizontalEvents
        ? HorizontalImagingTimeline.new
        : VerticalImagingTimeline.new)(events: events, sinceNote: sinceNote),
  );
}
