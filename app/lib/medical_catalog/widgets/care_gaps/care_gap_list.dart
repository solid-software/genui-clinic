import 'package:clinical_brief/common/widgets/divided_column.dart';
import 'package:clinical_brief/medical_catalog/models/care_gap.dart';
import 'package:clinical_brief/medical_catalog/widgets/care_gaps/care_gap_row.dart';
import 'package:flutter/material.dart';

/// Things the record says are due, overdue or never done.
class const CareGapList({
  super.key,

  /// The items, most overdue or most relevant first.
  required final List<CareGap> gaps,
}) extends StatelessWidget {
  /// Creates a care gap list.
  this;

  @override
  Widget build(BuildContext context) => DividedColumn(
    children: gaps.map((gap) => CareGapRow(gap: gap)).toList(),
  );
}
