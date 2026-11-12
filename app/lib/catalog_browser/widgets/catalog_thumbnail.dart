import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// A component's live preview, cut to a fixed height and inert, so a tap
/// reaches the card around it.
///
/// Shows nothing for a component with no example to draw (a kept basic
/// component, say).
class const CatalogThumbnail({
  super.key,

  /// The surface drawing the component, or `null` without one.
  required final SurfaceModel<ComponentImplementation>? surface,
}) extends StatelessWidget {
  static const _height = 200.0;

  /// Creates the thumbnail.
  this;

  @override
  Widget build(BuildContext context) {
    final surface = this.surface;
    if (surface == null) {
      return const SizedBox(height: _height);
    }

    return SizedBox(
      height: _height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.tileRadius),
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          // Inert: taps, focus and screen readers go to the card instead.
          child: IgnorePointer(
            child: ExcludeFocus(
              child: ExcludeSemantics(
                // As tall as the component draws itself; the box cuts it off.
                child: OverflowBox(
                  alignment: .topCenter,
                  minHeight: 0.0,
                  maxHeight: .infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: A2uiSurface(surface: surface),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
