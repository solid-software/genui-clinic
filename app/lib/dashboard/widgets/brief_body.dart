import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/common/widgets/centered_list_view.dart';
import 'package:clinical_brief/common/widgets/error_message.dart';
import 'package:clinical_brief/dashboard/state/dashboard_controller.dart';
import 'package:clinical_brief/dashboard/widgets/brief_header.dart';
import 'package:clinical_brief/dashboard/widgets/brief_progress.dart';
import 'package:clinical_brief/dashboard/widgets/dashboard_top_row.dart';
import 'package:clinical_brief/dashboard/widgets/full_record/full_record_section.dart';
import 'package:clinical_brief/dashboard/widgets/updating_banner.dart';
import 'package:clinical_brief/medical_catalog/motion/motion_scope.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';

/// The whole page, rebuilt whenever the controller changes.
class const BriefBody({
  super.key,

  /// The consultation on screen.
  required final DashboardController controller,

  /// Called with a finding the doctor typed into the refine field.
  required final ValueChanged<String> onRefine,
}) extends StatelessWidget {
  static const _bannerResize = Duration(milliseconds: 250);

  /// Creates brief body.
  this;

  @override
  Widget build(BuildContext context) {
    final error = controller.errorMessage;

    return CenteredListView(
      maxWidth: AppSpacing.dashboardMaxWidth,
      children: [
        const DashboardTopRow(),
        const SizedBox(height: AppSpacing.xl),
        BriefHeader(controller: controller, onRefine: onRefine),
        const SizedBox(height: AppSpacing.cardGap),
        if (error != null)
          ErrorMessage.banner(
            message: error,
            onRetry: controller.canRetry || controller.retryAt != null
                ? controller.retry
                : null,
            retryAt: controller.retryAt,
          ),
        ..._briefSections(),
      ],
    );
  }

  /// Below the header: a placeholder, then the brief and the full record.
  List<Widget> _briefSections() {
    final surfaceId = controller.activeSurfaceId;
    if (surfaceId == null) {
      return [
        if (controller.isComposing || controller.errorMessage == null)
          BriefProgress(
            title: 'Composing the brief',
            detail: _waitingDetail(controller.complaint),
          ),
      ];
    }
    final record = controller.record;

    return [
      // Always present so the brief keeps its list slot; a shifted slot
      // rebuilds the brief's cards and loses their state.
      AnimatedSize(
        duration: _bannerResize,
        alignment: Alignment.topCenter,
        child: controller.isComposing
            ? UpdatingBanner(detail: _waitingDetail(controller.complaint))
            : const SizedBox(width: double.infinity),
      ),
      // Keyed so the list keeps this scope as the error line comes and goes.
      MotionScope(
        key: const ValueKey('brief-motion-scope'),
        generation: surfaceId,
        child: Surface(
          key: ValueKey(surfaceId),
          surfaceContext: controller.surfaceHost.contextFor(surfaceId),
        ),
      ),
      if (record != null)
        FullRecordSection(
          key: const ValueKey('full-record'),
          record: record,
        ),
    ];
  }

  /// Progress text naming the newest finding, or the complaint if none.
  static String _waitingDetail(Complaint complaint) => complaint.addenda.isEmpty
      ? 'Reading the record against '
            '\u201c${complaint.presentingText}\u201d\u2026'
      : 'Adding \u201c${complaint.addenda.last}\u201d to the brief\u2026';
}
