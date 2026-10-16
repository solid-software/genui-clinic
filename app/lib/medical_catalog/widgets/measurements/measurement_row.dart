import 'package:clinical_brief/medical_catalog/models/measurement.dart';
import 'package:clinical_brief/medical_catalog/widgets/measurements/measurement_tile.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Today's measurements as tiles in large type.
class const MeasurementRow({
  super.key,

  /// The tiles, most important first.
  required final List<Measurement> measurements,
}) extends StatelessWidget {
  static const double _minTileWidth = 150.0;

  /// Creates a measurement row.
  this;

  @override
  Widget build(BuildContext context) => Padding(
    // Not in a SectionCard, so the row adds the gap below itself; with each
    // row's own gap it comes to one card gap.
    padding: const EdgeInsets.only(bottom: AppSpacing.cardGap - AppSpacing.md),
    child: LayoutBuilder(
      builder: (_, constraints) {
        final int columns = _columnsFor(constraints.maxWidth);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (int start = 0; start < measurements.length; start += columns)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                // One height per row, whether or not a tile has a meta line.
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: AppSpacing.md,
                    children: <Widget>[
                      for (int index = start; index < start + columns; index++)
                        Expanded(
                          child: index < measurements.length
                              ? MeasurementTile(
                                  measurement: measurements[index],
                                )
                              // Fills the last row so tiles keep their width.
                              : const SizedBox.shrink(),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    ),
  );

  /// How many tiles fit on one row, never more than there are.
  int _columnsFor(double width) {
    final int fitting = (width / _minTileWidth).floor();

    return fitting.clamp(1, measurements.isEmpty ? 1 : measurements.length);
  }
}
