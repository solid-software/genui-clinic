import 'package:clinical_brief/common/widgets/app_text_field.dart';
import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// The search field and today's date, side by side or stacked when narrow.
class const PatientListTopBar({
  super.key,

  /// Holds the search text, so it outlives the field when the list
  /// rebuilds it.
  required final TextEditingController search,

  /// Called with the search text as it is typed.
  required final ValueChanged<String> onSearch,
}) extends StatelessWidget {
  static const _searchMaxWidth = 480.0;
  static const _sideBySideMinWidth = 600.0;
  static final _date = DateFormat('EEEE, d MMMM');

  /// Creates the bar.
  this;

  @override
  Widget build(BuildContext context) {
    final field = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: _searchMaxWidth),
      child: AppTextField.search(
        controller: search,
        hintText: 'Search patient name',
        onChanged: onSearch,
      ),
    );
    final date = PillChip(
      label: _date.format(.now()),
      icon: Icons.calendar_today_outlined,
      color: Theme.of(context).colorScheme.surface,
      prominent: true,
    );

    return LayoutBuilder(
      builder: (_, constraints) => constraints.maxWidth >= _sideBySideMinWidth
          ? Row(
              spacing: AppSpacing.md,
              children: [
                Expanded(
                  child: Align(alignment: .centerLeft, child: field),
                ),
                date,
              ],
            )
          : Column(
              spacing: AppSpacing.md,
              crossAxisAlignment: .start,
              children: [
                field,
                date,
              ],
            ),
    );
  }
}
