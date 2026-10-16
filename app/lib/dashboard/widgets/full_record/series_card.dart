import 'package:clinical_brief/check_in/models/observation_point.dart';
import 'package:clinical_brief/check_in/models/observation_series.dart';
import 'package:clinical_brief/common/utils/date_formatting.dart';
import 'package:clinical_brief/common/utils/number_formatting.dart';
import 'package:clinical_brief/dashboard/widgets/full_record/record_card.dart';
import 'package:flutter/material.dart';

/// One series, newest reading first, out-of-range values flagged.
class const SeriesCard({
  super.key,

  /// The series shown.
  required final ObservationSeries series,
}) extends StatelessWidget {
  /// Creates series card.
  this;

  @override
  Widget build(BuildContext context) {
    final ObservationSeries(
      referenceLow: low,
      referenceHigh: high,
      displayName: title,
      unit: titleTrailing,
      :points,
    ) = series;

    return RecordCard(
      title: title,
      titleTrailing: titleTrailing,
      rows: [
        for (final ObservationPoint(:value, :recordedBy, :takenAt)
            in points.reversed)
          .new(
            label: DateFormatting.monthYear(takenAt),
            detail: recordedBy,
            trailing: NumberFormatting.compact(value),
            trailingTone: value < (low ?? value) || value > (high ?? value)
                ? .warning
                : .neutral,
            emphasiseTrailing: true,
          ),
      ],
    );
  }
}
