import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:clinical_brief/medical_catalog/motion/motion_paint.dart';
import 'package:clinical_brief/medical_catalog/motion/motion_scope.dart';
import 'package:clinical_brief/medical_catalog/motion/motion_track.dart';
import 'package:clinical_brief/medical_catalog/motion/new_tag.dart';
import 'package:clinical_brief/medical_catalog/motion/render_snapshot_boundary.dart';
import 'package:clinical_brief/medical_catalog/motion/snapshot_boundary.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';

/// A brief section that, on a new brief, glides from its old place, lifts
/// in place, or grows in with a "New" tag.
class const MotionCard({
  super.key,

  /// Identity across briefs: type and title, since component ids change.
  required final String motionKey,

  /// The section.
  required final Widget child,
}) extends StatefulWidget {
  /// Creates brief section for animation.
  this;

  /// Wraps a catalog section, keyed by its component type and title.
  ///
  /// An untitled one (a chart group) is keyed by its children's titles.
  factory MotionCard.section(CatalogItemContext itemContext, Widget child) {
    final name = switch (itemContext.data) {
      {'title': final String title} => title,
      {'children': final List<Object?> children} =>
        children
            .whereType<String>()
            .map(
              (id) => itemContext.getComponent(id)?.properties['title'] ?? id,
            )
            .join('+'),
      _ => '',
    };

    return MotionCard(motionKey: '${itemContext.type}:$name', child: child);
  }

  @override
  State<MotionCard> createState() => _MotionCardState();
}

class _MotionCardState extends State<MotionCard>
    with SingleTickerProviderStateMixin {
  /// The whole transition, including the time the "New" tag stays up.
  static const _duration = Duration(milliseconds: 2800);

  /// The share of [_duration] the movement takes; the rest is for the tag.
  static const _moveShare = 0.5;

  /// Share of [_duration] a new section fades in over, well before it lands.
  static const _fadeShare = 0.25;

  /// A move shorter than this is a section staying where it was.
  static const _stillDistance = 4.0;

  /// Start delay per pixel down the page, and its cap.
  static const _staggerPerPixel = 0.2;
  static const _maxStaggerMs = 400;

  /// Weights of the "New" tag's phases: hidden, fading in, held, fading out.
  static const _tagHiddenWeight = 3.0;
  static const _tagInWeight = 1.0;
  static const _tagHeldWeight = 4.0;
  static const _tagOutWeight = 2.0;

  /// Pixel-ratio cap for exit snapshots; more is wasted on a shrinking card.
  static const _maxSnapshotRatio = 2.0;

  /// The content the exit snapshot is taken of.
  final _content = GlobalKey();
  late final _progress = AnimationController(
    vsync: this,
    duration: _duration,
    value: 1.0,
  );

  /// The movement, eased over the first part of the transition.
  late final _move = CurvedAnimation(
    parent: _progress,
    curve: const Interval(
      0,
      _moveShare,
      curve: Curves.easeInOutCubicEmphasized,
    ),
  );

  /// How visible a new section is.
  late final _fade = CurvedAnimation(
    parent: _progress,
    curve: const Interval(0, _fadeShare, curve: Curves.easeOut),
  );

  /// The "New" tag: in as the card lands, held, then out at the end.
  late final _tag = TweenSequence([
    .new(tween: ConstantTween(0.0), weight: _tagHiddenWeight),
    .new(tween: Tween(begin: 0.0, end: 1.0), weight: _tagInWeight),
    .new(tween: ConstantTween(1.0), weight: _tagHeldWeight),
    .new(tween: Tween(begin: 1.0, end: 0.0), weight: _tagOutWeight),
  ]).animate(_progress);
  late final _track = MotionTrack(
    progress: _progress,
    move: _move,
    fade: _fade,
    onFirstPaint: _measure,
  );
  Object? _generation;
  MotionScopeState? _scope;
  var _pixelRatio = 1.0;

  @override
  Widget build(BuildContext context) => MotionPaint(
    track: _track,
    child: AnimatedBuilder(
      animation: _tag,
      builder: (_, content) => NewTag(
        visibility: _track.change == .entered ? _tag.value : 0,
        child: content,
      ),
      // Painted once and moved as a picture, not redrawn every frame.
      child: SnapshotBoundary(key: _content, child: widget.child),
    ),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pixelRatio = math.min(
      MediaQuery.maybeDevicePixelRatioOf(context) ?? 1,
      _maxSnapshotRatio,
    );
    final scope = MotionScope.maybeOf(context);
    if (scope != _scope) {
      _scope?.removeRecorder(_recordNow);
      scope?.addRecorder(_recordNow);
      _scope = scope;
    }
    if (scope == null || scope.generation == _generation) return;
    _generation = scope.generation;
    if (!scope.hasPrevious) return;
    // Held at the start until the first paint finds where it came from.
    _track.pending = true;
    _progress.value = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) => _showIfNeverPainted());
  }

  @override
  void didUpdateWidget(MotionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final scope = MotionScope.maybeOf(context);
    if (scope == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => _record(scope));
  }

  @override
  void dispose() {
    _scope?.removeRecorder(_recordNow);
    _fade.dispose();
    _move.dispose();
    _progress.dispose();
    super.dispose();
  }

  /// Decides what this section does from its old and new places.
  ///
  /// Runs during paint, so the movement only starts after the frame.
  void _measure(RenderBox box) {
    final scope = _scope;
    if (scope == null) return;
    final before = scope.claimPreviousRect(widget.motionKey);
    scope.record(widget.motionKey, box);
    final after = scope.currentRectOf(widget.motionKey);
    final from = before != null && after != null
        ? before.topLeft - after.topLeft
        : Offset.zero;
    _track
      ..from = from
      ..change = before == null || after == null
          ? .entered
          : from.distance > _stillDistance
          ? .moved
          : .kept;
    final delay = _staggerFor(after);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => unawaited(_startAfter(delay)),
    );
  }

  /// Shows in place a section the first frame never painted (off screen).
  void _showIfNeverPainted() {
    if (!mounted || !_track.pending) return;
    _track.pending = false;
    _progress.value = 1;
  }

  /// Start delay for a section at [place], growing down the page.
  Duration _staggerFor(Rect? place) => Duration(
    milliseconds: place == null
        ? 0
        : (place.top * _staggerPerPixel).round().clamp(
            0,
            _maxStaggerMs,
          ),
  );

  Future<void> _startAfter(Duration delay) async {
    if (delay > .zero) {
      await Future.delayed(delay);
    }
    if (mounted) {
      _progress.forward(from: 0);
    }
  }

  /// Records this card's place and snapshot before the brief is replaced.
  void _recordNow() {
    final scope = _scope;
    if (scope == null) return;
    _record(scope);
    final picture = _snapshot();
    if (picture != null) {
      scope.keepSnapshot(widget.motionKey, picture);
    }
  }

  /// The content as last drawn, or `null` if it has not been drawn.
  ui.Image? _snapshot() {
    final content = _content.currentContext?.findRenderObject();

    return content is RenderSnapshotBoundary
        ? content.snapshot(_pixelRatio)
        : null;
  }

  void _record(MotionScopeState scope) {
    if (!mounted) return;
    final box = context.findRenderObject();
    if (box is RenderBox) {
      scope.record(widget.motionKey, box);
    }
  }
}
