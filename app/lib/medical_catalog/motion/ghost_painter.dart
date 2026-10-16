import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:clinical_brief/medical_catalog/motion/motion_ghost.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/widgets.dart';

/// Draws leaving sections shrinking and sliding down into the record.
class GhostPainter extends CustomPainter {
  /// How small a leaving section gets before it is gone.
  static const double _endScale = 0.3;

  /// The share of its flight after which a leaving section fades out.
  static const double _fadeFrom = 0.45;

  /// Material's emphasized accelerate easing.
  static const Curve _curve = Cubic(0.3, 0, 0.8, 0.15);

  static const double _shadowSigma = 12.0;
  static const double _shadowOpacity = 0.18;
  static const Offset _shadowOffset = Offset(0, 8);
  static const Color _black = Color(0xFF000000);

  /// The sections leaving.
  final List<MotionGhost> ghosts;

  /// Keys the new brief has taken over; those sections are not leaving.
  final Set<String> claimed;

  /// Where leaving sections go, or `null` before they set off.
  final Offset? landing;

  /// The whole departure.
  final Animation<double> progress;

  /// The share of the whole departure one section's flight takes.
  final double flightShare;

  /// Creates the painter.
  GhostPainter({
    required this.ghosts,
    required this.claimed,
    required this.landing,
    required this.progress,
    required this.flightShare,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (final MotionGhost ghost in ghosts) {
      if (!claimed.contains(ghost.key)) {
        _paintGhost(canvas, ghost);
      }
    }
  }

  @override
  bool shouldRepaint(GhostPainter oldDelegate) =>
      !identical(oldDelegate.ghosts, ghosts) || oldDelegate.landing != landing;

  void _paintGhost(Canvas canvas, MotionGhost ghost) {
    final Offset? target = landing;
    final double t = target == null
        ? 0
        : ((progress.value - ghost.start) / flightShare).clamp(0.0, 1.0);
    final double eased = _curve.transform(t);
    final Offset from = ghost.from.center;
    final Offset centre = target == null
        ? from
        : from + (target - from) * eased;
    final double scale = 1 - (1 - _endScale) * eased;
    final double opacity = t <= _fadeFrom
        ? 1
        : 1 - (t - _fadeFrom) / (1 - _fadeFrom);
    if (opacity <= 0) {
      return;
    }
    final Rect area = Rect.fromCenter(
      center: centre,
      width: ghost.from.width * scale,
      height: ghost.from.height * scale,
    );
    final double lift = math.sin(t * math.pi) * opacity;
    if (lift > 0) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          area.shift(_shadowOffset * lift),
          Radius.circular(AppSpacing.cardRadius * scale),
        ),
        Paint()
          ..color = _black.withValues(alpha: _shadowOpacity * lift)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, _shadowSigma),
      );
    }
    final ui.Image picture = ghost.picture;
    canvas.drawImageRect(
      picture,
      Offset.zero & Size(picture.width.toDouble(), picture.height.toDouble()),
      area,
      Paint()
        ..color = _black.withValues(alpha: opacity)
        ..filterQuality = FilterQuality.medium,
    );
  }
}
