import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:clinical_brief/medical_catalog/motion/ghost_painter.dart';
import 'package:clinical_brief/medical_catalog/motion/motion_ghost.dart';
import 'package:clinical_brief/medical_catalog/motion/motion_scope_marker.dart';
import 'package:flutter/widgets.dart';

/// Remembers where brief sections sat so the next brief can move them from
/// there, and sends the sections it drops down into the record.
class const MotionScope({
  super.key,

  /// Identifies the brief on screen; changing it starts a transition.
  required final Object generation,

  /// The brief.
  required final Widget child,
}) extends StatefulWidget {
  /// Creates a motion scope.
  this;

  /// The nearest scope's state, or `null` outside one.
  static MotionScopeState? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MotionScopeMarker>()?.state;

  @override
  State<MotionScope> createState() => MotionScopeState();
}

/// Section places across briefs, and pictures of sections on their way out.
class MotionScopeState extends State<MotionScope>
    with
        SingleTickerProviderStateMixin<MotionScope>,
        AutomaticKeepAliveClientMixin<MotionScope> {
  /// Between the type and the title in a motion key, e.g. `LabPanel:Labs`.
  static const String _typeSeparator = ':';

  /// How long a leaving section takes to reach the record.
  static const int _flightMs = 1000;

  /// Longest start delay of a leaving section; lower ones leave later.
  static const int _staggerMs = 250;
  static const double _staggerPerPixel = 0.15;

  /// The share of the whole departure one section's flight takes.
  static const double _flightShare = _flightMs / (_flightMs + _staggerMs);

  /// How far below the brief's bottom edge leaving sections aim.
  static const double _recordHeaderInset = 40.0;

  /// Landing gap above the screen bottom when the record is off screen.
  static const double _screenMargin = 48.0;

  /// Factor for the horizontal centre of the brief.
  static const double _half = 0.5;

  final GlobalKey _boundary = GlobalKey();
  final Map<String, Rect> _current = <String, Rect>{};
  final Set<String> _claimed = <String>{};
  final Set<VoidCallback> _recorders = <VoidCallback>{};
  final Map<String, ui.Image> _snapshots = <String, ui.Image>{};

  late final AnimationController _departure = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: _flightMs + _staggerMs),
  );

  Map<String, Rect> _previous = <String, Rect>{};
  List<MotionGhost> _ghosts = const <MotionGhost>[];
  Offset? _landing;

  /// The brief on screen.
  Object get generation => widget.generation;

  /// Kept alive, or the lazy list disposes it and every card's place is lost.
  @override
  bool get wantKeepAlive => true;

  /// Whether a brief was on screen before this one.
  bool get hasPrevious => _previous.isNotEmpty;

  /// Claims the previous place of [key], or of the only earlier section of
  /// its type so a renamed card still moves; `null` if none is free.
  Rect? claimPreviousRect(String key) {
    final Rect? exact = _previous[key];
    if (exact != null && _claimed.add(key)) {
      return exact;
    }
    final String type = key.split(_typeSeparator).first;
    final List<String> sameType = _previous.keys
        .where((previous) => previous.startsWith('$type$_typeSeparator'))
        .toList();
    if (sameType.length != 1 || !_claimed.add(sameType.single)) {
      return null;
    }

    return _previous[sameType.single];
  }

  /// Where the section under [key] sits in this brief, once laid out.
  Rect? currentRectOf(String key) => _current[key];

  /// Lets a section re-measure itself just before the brief is replaced.
  void addRecorder(VoidCallback recorder) => _recorders.add(recorder);

  /// Stops asking a section that has gone.
  void removeRecorder(VoidCallback recorder) => _recorders.remove(recorder);

  /// Records where the section under [key] sits now.
  void record(String key, RenderBox box) {
    final RenderObject? boundary = _boundary.currentContext?.findRenderObject();
    if (boundary is! RenderBox || !box.attached || !box.hasSize) {
      return;
    }
    final Offset origin = box.localToGlobal(Offset.zero, ancestor: boundary);
    _current[key] = origin & box.size;
  }

  /// Keeps [picture] of [key] in case the next brief leaves it out.
  void keepSnapshot(String key, ui.Image picture) {
    _snapshots.remove(key)?.dispose();
    _snapshots[key] = picture;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<MotionGhost> ghosts = _ghosts;

    return MotionScopeMarker(
      state: this,
      generation: widget.generation,
      child: KeyedSubtree(
        key: _boundary,
        child: Stack(
          // Sizes the brief as if the ghost layer were not there.
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          children: <Widget>[
            widget.child,
            if (ghosts.isNotEmpty)
              Positioned.fill(
                child: IgnorePointer(
                  child: RepaintBoundary(
                    child: CustomPaint(
                      painter: GhostPainter(
                        ghosts: ghosts,
                        claimed: _claimed,
                        landing: _landing,
                        progress: _departure,
                        flightShare: _flightShare,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(MotionScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.generation == widget.generation) {
      return;
    }
    _disposeGhosts();
    // The old brief is still laid out here: measure it now, after late
    // layout changes, not where cards first appeared.
    for (final VoidCallback recorder in List<VoidCallback>.of(_recorders)) {
      recorder();
    }
    _previous = Map<String, Rect>.of(_current);
    _current.clear();
    _claimed.clear();
    // Unclaimed pictures hold their old place for one frame, then leave.
    _ghosts = _ghostsFromSnapshots();
    if (_ghosts.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _launchGhosts());
    }
  }

  @override
  void dispose() {
    _disposeGhosts();
    for (final ui.Image picture in _snapshots.values) {
      picture.dispose();
    }
    _snapshots.clear();
    _departure.dispose();
    super.dispose();
  }

  List<MotionGhost> _ghostsFromSnapshots() {
    final List<MotionGhost> ghosts = <MotionGhost>[];
    for (final MapEntry<String, ui.Image> snapshot in _snapshots.entries) {
      final Rect? from = _previous[snapshot.key];
      if (from == null) {
        snapshot.value.dispose();
      } else {
        ghosts.add(
          MotionGhost(key: snapshot.key, picture: snapshot.value, from: from),
        );
      }
    }
    _snapshots.clear();

    return ghosts;
  }

  /// Sends unclaimed sections off once the first frame's claims are in.
  void _launchGhosts() {
    if (!mounted) {
      return;
    }
    final RenderObject? brief = _boundary.currentContext?.findRenderObject();
    final Offset? landing = brief is RenderBox && brief.hasSize
        ? _landingPoint(brief)
        : null;
    final List<MotionGhost> leaving = <MotionGhost>[];
    for (final MotionGhost ghost in _ghosts) {
      if (landing != null && _isLeaving(ghost, landing)) {
        leaving.add(ghost..start = _startOf(ghost));
      } else {
        ghost.picture.dispose();
      }
    }
    setState(() {
      _ghosts = leaving;
      _landing = landing;
    });
    if (leaving.isNotEmpty) {
      unawaited(_departure.forward(from: 0).whenComplete(_finishGhosts));
    }
  }

  /// Where leaving sections go: just under the brief, or above the screen
  /// bottom when that is off screen, so the landing is always seen.
  Offset _landingPoint(RenderBox brief) {
    double y = brief.size.height + _recordHeaderInset;
    final RenderObject? screen = context
        .findAncestorStateOfType<ScrollableState>()
        ?.context
        .findRenderObject();
    if (screen is RenderBox && screen.hasSize) {
      final Offset screenBottom = screen.localToGlobal(
        Offset(0, screen.size.height),
      );
      y = math.min(y, brief.globalToLocal(screenBottom).dy - _screenMargin);
    }

    return Offset(brief.size.width * _half, y);
  }

  /// Whether [ghost] was left out and sat above [landing]; one below it is
  /// already where the record now is.
  bool _isLeaving(MotionGhost ghost, Offset landing) =>
      !_claimed.contains(ghost.key) && ghost.from.top < landing.dy;

  /// When [ghost] sets off, as a share of the whole departure.
  double _startOf(MotionGhost ghost) =>
      math.min(ghost.from.top * _staggerPerPixel, _staggerMs.toDouble()) /
      (_flightMs + _staggerMs);

  void _finishGhosts() {
    if (mounted) {
      setState(_disposeGhosts);
    }
  }

  void _disposeGhosts() {
    _departure.stop();
    for (final MotionGhost ghost in _ghosts) {
      ghost.picture.dispose();
    }
    _ghosts = const <MotionGhost>[];
    _landing = null;
  }
}
