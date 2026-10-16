import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/check_in/widgets/stats/stat_tile.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// Today at a glance: who is next, who is waiting, how many patients are
/// checked in and the doctors on duty.
class const PatientStats({
  super.key,

  /// Everyone on today's list.
  required final List<Patient> patients,

  /// Those not checked in yet, in slot order.
  required final List<Patient> waiting,
}) extends StatelessWidget {
  static const double _fourColumnMinWidth = 880.0;
  static const double _twoColumnMinWidth = 440.0;
  static const int _wideColumns = 4;
  static const int _mediumColumns = 2;

  /// Creates the stats row.
  this;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final next = waiting.isEmpty ? null : waiting.first;
    final doctors = patients
        .map((patient) => patient.attendingDoctor)
        .toSet()
        .length;

    final tiles = <StatTile>[
      .new(
        icon: Icons.schedule,
        value: next?.slotTime ?? '\u2013',
        label: 'Next',
        caption: next == null
            ? 'everyone is checked in'
            : '${next.fullName} \u00b7 ${next.attendingDoctor}',
        color: colors.tertiaryContainer,
      ),
      .new(
        icon: Icons.person_outline,
        value: '${waiting.length}',
        label: 'Waiting',
        caption: 'patients in the queue',
        color: colors.primaryContainer,
      ),
      .new(
        icon: Icons.check,
        value: '${patients.length - waiting.length}',
        label: 'Checked in',
        caption: 'of ${patients.length} today',
        color: colors.secondaryContainer,
      ),
      .new(
        icon: Icons.medical_services_outlined,
        value: '$doctors',
        label: doctors == 1 ? 'Doctor' : 'Doctors',
        caption: 'same-day slots today',
        color: colors.surface,
        iconColor: colors.errorContainer,
        iconForeground: colors.error,
      ),
    ];

    return LayoutBuilder(
      builder: (_, constraints) {
        final columns = constraints.maxWidth >= _fourColumnMinWidth
            ? _wideColumns
            : constraints.maxWidth >= _twoColumnMinWidth
            ? _mediumColumns
            : 1;

        return Column(
          spacing: AppSpacing.cardGap,
          children: tiles
              .slices(columns)
              .toList()
              .map(
                (row) =>
                    // One height per row, whatever each caption wraps to.
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: .stretch,
                        spacing: AppSpacing.cardGap,
                        children: row
                            .map((tile) => Expanded(child: tile))
                            .toList(),
                      ),
                    ),
              )
              .toList(),
        );
      },
    );
  }
}
