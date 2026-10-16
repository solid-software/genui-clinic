import 'package:clinical_brief/check_in/models/check_in.dart';
import 'package:clinical_brief/check_in/widgets/recent_check_ins/check_in_row.dart';
import 'package:clinical_brief/common/widgets/divided_column.dart';
import 'package:clinical_brief/common/widgets/panel_card.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The patients checked in this session, newest first.
class const RecentCheckInsCard({
  super.key,

  /// The check-ins, newest first.
  required final List<CheckIn> checkIns,
}) extends StatelessWidget {
  static const _dividerOpacity = 0.8;

  /// Creates recent check-ins card.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final divider = colors.surface.withValues(alpha: _dividerOpacity);
    final bodyStyle = theme.textTheme.bodyMedium?.copyWith(
      color: colors.onSecondaryContainer,
    );

    return PanelCard(
      icon: Icons.check,
      title: 'Recent check-ins',
      color: colors.secondaryContainer,
      child: DividedColumn(
        hasLeadingDivider: true,
        dividerColor: divider,
        crossAxisAlignment: .stretch,
        children: [
          if (checkIns.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.md),
              child: Text(
                'Nothing yet. Patients you check in will appear here.',
                style: bodyStyle,
              ),
            ),
          for (final checkIn in checkIns) CheckInRow(checkIn: checkIn),
        ],
      ),
    );
  }
}
