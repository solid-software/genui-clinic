import 'package:clinical_brief/medical_catalog/motion/motion_track.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/rendering.dart';

/// Moves, scales, fades and lifts its child using layers only, so the child
/// behind its repaint boundary is painted once.
class RenderMotion extends RenderProxyBox {
  /// Shadow at the top of a lift. Only its strength animates: a changing
  /// blur is costly to draw every frame.
  static const _shadowSigma = 14.0;
  static const _shadowOpacity = 0.2;
  static const _shadowColor = Color(0xFF000000);
  static const _shadowOffset = Offset(0, 10);
  final _transformLayer = LayerHandle<TransformLayer>();
  MotionTrack _track;

  /// The transition this render object draws.
  MotionTrack get track => _track;

  set track(MotionTrack value) {
    if (identical(value, _track)) return;

    if (attached) {
      _track.progress.removeListener(markNeedsPaint);
      value.progress.addListener(markNeedsPaint);
    }
    _track = value;
    markNeedsPaint();
  }

  @override
  bool get alwaysNeedsCompositing => child != null;

  /// Creates the render object for [track].
  RenderMotion(this._track);

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _track.progress.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _track.progress.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  void dispose() {
    _transformLayer.layer = null;
    super.dispose();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child == null) return _clearLayers();
    _track.measureIfPending(this);
    final frame = _track.frame;
    if (frame.isStill) {
      _clearLayers();
      context.paintChild(child, offset);

      return;
    }
    final alpha = Color.getAlphaFromOpacity(frame.opacity);
    if (alpha == 0) return _clearLayers();
    final transform = frame.transformFor(size);
    layer = context.pushOpacity(
      offset,
      alpha,
      (faded, origin) {
        _transformLayer.layer = faded.pushTransform(
          needsCompositing,
          origin,
          transform,
          (moved, at) {
            _paintShadow(moved.canvas, at, frame.lift);
            moved.paintChild(child, at);
          },
          oldLayer: _transformLayer.layer,
        );
      },
      oldLayer: layer as OpacityLayer?,
    );
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      result.addWithPaintTransform(
        transform: _track.frame.transformFor(size),
        position: position,
        hitTest: (moved, local) =>
            super.hitTestChildren(moved, position: local),
      );

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.multiply(_track.frame.transformFor(size));
  }

  void _clearLayers() {
    layer = null;
    _transformLayer.layer = null;
  }

  void _paintShadow(Canvas canvas, Offset at, double lift) {
    if (lift <= 0) return;
    final area = (at + _shadowOffset * lift) & size;
    canvas.drawRRect(
      .fromRectAndRadius(
        area,
        const .circular(AppSpacing.cardRadius),
      ),
      Paint()
        ..color = _shadowColor.withValues(alpha: _shadowOpacity * lift)
        ..maskFilter = const .blur(.normal, _shadowSigma),
    );
  }
}
