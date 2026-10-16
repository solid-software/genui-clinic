import 'package:clinical_brief/check_in/models/patient.dart';
import 'package:clinical_brief/check_in/widgets/doctors/doctor_row.dart';
import 'package:clinical_brief/common/widgets/divided_column.dart';
import 'package:clinical_brief/common/widgets/panel_card.dart';
import 'package:flutter/material.dart';

/// Each doctor's slot today and whether their patient has arrived.
class const DoctorsTodayCard({
  super.key,

  /// Today's list, one slot per patient, in slot order.
  required final List<Patient> patients,

  /// Whether a patient was checked in this session.
  required final bool Function(Patient patient) isCheckedIn,
}) extends StatelessWidget {
  /// Creates the card.
  this;

  @override
  Widget build(BuildContext context) => PanelCard(
    icon: Icons.person_outline,
    title: 'Doctors today',
    subtitle: 'Same-day slots',
    child: DividedColumn(
      hasLeadingDivider: true,
      crossAxisAlignment: .stretch,
      children: [
        for (final patient in patients)
          DoctorRow(patient: patient, arrived: isCheckedIn(patient)),
      ],
    ),
  );
}
