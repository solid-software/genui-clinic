import 'dart:async';

import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/check_in/state/patient_list_controller.dart';
import 'package:clinical_brief/check_in/widgets/doctors/doctors_today_card.dart';
import 'package:clinical_brief/check_in/widgets/patient_list_top_bar.dart';
import 'package:clinical_brief/check_in/widgets/recent_check_ins/recent_check_ins_card.dart';
import 'package:clinical_brief/check_in/widgets/stats/patient_stats.dart';
import 'package:clinical_brief/check_in/widgets/waiting_list/waiting_list_card.dart';
import 'package:clinical_brief/common/widgets/centered_list_view.dart';
import 'package:clinical_brief/common/widgets/error_message.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Today's list: the search, the stats, the waiting list, the doctors and
/// the check-ins so far.
class const PatientListBody({
  super.key,

  /// Today's list, the search and the check-ins.
  required final PatientListController controller,

  /// The search text, kept by the screen so it outlives this body.
  required final TextEditingController search,

  /// Called to check a patient in.
  required final ValueChanged<Patient> onCheckIn,
}) extends StatelessWidget {
  static const _twoColumnMinWidth = 880.0;
  static const _doctorsFlex = 3;
  static const _checkInsFlex = 2;

  /// Creates today's list: the search, the stats, the waiting list, the
  /// doctors and the check-ins so far.
  this;

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.errorMessage case final error?) {
      return ErrorMessage.centered(
        message: error,
        onRetry: () => unawaited(controller.load()),
      );
    }
    final doctors = DoctorsTodayCard(
      patients: controller.patients,
      isCheckedIn: controller.isCheckedIn,
    );
    final checkIns = RecentCheckInsCard(checkIns: controller.checkIns);

    return CenteredListView(
      maxWidth: AppSpacing.contentMaxWidth,

      children: [
        PatientStats(
          patients: controller.patients,
          waiting: controller.waitingPatients,
        ),
        const SizedBox(height: AppSpacing.cardGap),
        PatientListTopBar(search: search, onSearch: controller.search),
        const SizedBox(height: AppSpacing.cardGap),
        WaitingListCard(
          patients: controller.matchingPatients,
          query: controller.query,
          isCheckedIn: controller.isCheckedIn,
          onCheckIn: onCheckIn,
        ),
        const SizedBox(height: AppSpacing.cardGap),
        LayoutBuilder(
          builder: (_, constraints) =>
              constraints.maxWidth >= _twoColumnMinWidth
              // Both cards as tall as the taller one, as in a dashboard.
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: .stretch,
                    spacing: AppSpacing.cardGap,
                    children: [
                      Expanded(flex: _doctorsFlex, child: doctors),
                      Expanded(flex: _checkInsFlex, child: checkIns),
                    ],
                  ),
                )
              : Column(
                  spacing: AppSpacing.cardGap,
                  children: [doctors, checkIns],
                ),
        ),
      ],
    );
  }
}
