import 'package:clinical_brief/check_in/models/check_in.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// One check-in: who, why and when.
class const CheckInRow({
  super.key,

  /// The check-in shown.
  required final CheckIn checkIn,
}) extends StatelessWidget {
  static final _time = DateFormat.Hm();

  /// Creates check-in row.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ink = theme.colorScheme.onSecondaryContainer;
    final bodyMedium = theme.textTheme.bodyMedium?.copyWith(color: ink);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: .start,
        spacing: AppSpacing.md,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  checkIn.patient.nameAndAge,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: .w500,
                    color: ink,
                  ),
                ),
                Text(
                  checkIn.complaint.presentingText,
                  maxLines: 2,
                  overflow: .ellipsis,
                  style: bodyMedium,
                ),
              ],
            ),
          ),
          Text(
            _time.format(checkIn.at),
            style: bodyMedium?.copyWith(fontWeight: .w500),
          ),
        ],
      ),
    );
  }
}
