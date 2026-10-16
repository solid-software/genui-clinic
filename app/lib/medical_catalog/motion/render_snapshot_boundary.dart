import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

/// The render object of a `SnapshotBoundary`.
class RenderSnapshotBoundary extends RenderRepaintBoundary {
  /// What this boundary last drew, or `null` if it has not drawn yet.
  ui.Image? snapshot(double pixelRatio) =>
      // Debug builds also reject stale content; release builds, where
      // `debugNeedsPaint` is false, take the last (on-screen) drawing.
      !attached || !hasSize || layer == null || size.isEmpty || debugNeedsPaint
      ? null
      : toImageSync(pixelRatio: pixelRatio);
}
