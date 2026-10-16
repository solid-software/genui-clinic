import 'package:clinical_brief/medical_catalog/widgets/ecg/ecg_strip_painter.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// ECG rhythm strip generated from a rate and a rhythm, not a recording.
class const EcgStrip({
  super.key,

  /// Beats per minute the trace is drawn at.
  required final int rate,

  /// Whether the beats are unevenly spaced.
  final bool irregular = false,
}) extends StatelessWidget {
  static const _stripHeight = 96.0;

  /// Creates an ECG strip.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      child: SizedBox(
        height: _stripHeight,
        child: CustomPaint(
          size: .infinite,
          painter: EcgStripPainter(
            rate: rate,
            irregular: irregular,
            traceColor: theme.colorScheme.primary,
            gridColor: theme.colorScheme.outlineVariant,
          ),
        ),
      ),
    );
  }
}
