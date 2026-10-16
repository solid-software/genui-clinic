import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/common/widgets/gradient_orb.dart';
import 'package:clinical_brief/dashboard/widgets/header/composed_around.dart';
import 'package:clinical_brief/dashboard/widgets/header/header_title_row.dart';
import 'package:clinical_brief/dashboard/widgets/header/peach_glow.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The hero above the brief, rendered natively, never by the model: who is
/// being seen, what the brief is composed around, and the refine field.
class const DashboardHeader({
  super.key,

  /// The patient being seen.
  required final Patient patient,

  /// The complaint as it stands.
  required final Complaint complaint,

  /// The refine field, under the complaint chips it adds to.
  required final Widget refineField,

  /// Opens the demo case for this patient; the button is hidden when `null`.
  final VoidCallback? onShowDemoCase,
}) extends StatelessWidget {
  static const _wideMinWidth = 860.0;
  static const _radius = 28.0;
  static const _orbSize = 172.0;
  static const _orbInset = 36.0;

  /// Creates dashboard header widget
  this;

  /// Room kept clear of the orb on the right of the refine field.
  static const _orbClearance = _orbSize + _orbInset + _orbInset;
  static const _gradient = [
    Color(0xFFFDEAF2),
    Color(0xFFF6F0FB),
    Color(0xFFECE7FC),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final isWide = constraints.maxWidth >= _wideMinWidth;

        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_radius),
            gradient: const LinearGradient(
              begin: .topLeft,
              end: .bottomRight,
              colors: _gradient,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_radius),
            child: Stack(
              children: [
                const Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: PeachGlow(),
                ),
                if (isWide)
                  const Positioned(
                    right: _orbInset,
                    bottom: AppSpacing.xl,
                    child: GradientOrb(size: _orbSize),
                  ),
                Padding(
                  padding: EdgeInsets.all(
                    isWide ? AppSpacing.xxl : AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      HeaderTitleRow(
                        patient: patient,
                        isWide: isWide,
                        onShowDemoCase: onShowDemoCase,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Padding(
                        padding: EdgeInsets.only(
                          right: isWide ? _orbClearance : 0.0,
                        ),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            ComposedAround(complaint: complaint),
                            const SizedBox(height: AppSpacing.lg),
                            refineField,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
