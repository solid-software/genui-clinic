import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Placeholder in the brief's place while the first brief is composed.
class const BriefProgress({
  super.key,

  /// What is happening, in a few words.
  required final String title,

  /// The complaint or finding being composed around.
  required final String detail,
}) extends StatefulWidget {
  /// Creates the progress view.
  this;

  @override
  State<BriefProgress> createState() => _BriefProgressState();
}

class _BriefProgressState extends State<BriefProgress>
    with SingleTickerProviderStateMixin {
  static const Duration _pulse = Duration(milliseconds: 1100);
  static const double _spinnerSize = 20.0;
  static const double _spinnerWidth = 2.5;
  static const double _dimmest = 0.45;
  static const double _brightest = 1.0;

  /// Placeholder block heights: a banner, a pair of charts, then a list.
  static const List<double> _blockHeights = <double>[76.0, 200.0, 120.0];

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _pulse,
  )..repeat(reverse: true);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(
                width: _spinnerSize,
                height: _spinnerSize,
                child: CircularProgressIndicator(strokeWidth: _spinnerWidth),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      widget.detail,
                      style: theme.mutedBodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          // Card-sized blocks so the screen does not jump when cards arrive.
          FadeTransition(
            opacity: Tween<double>(
              begin: _dimmest,
              end: _brightest,
            ).animate(_controller),
            child: Column(
              children: <Widget>[
                for (final double height in _blockHeights)
                  Container(
                    height: height,
                    margin: const EdgeInsets.only(bottom: AppSpacing.cardGap),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.cardRadius,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
