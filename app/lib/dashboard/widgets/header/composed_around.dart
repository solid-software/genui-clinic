import 'package:clinical_brief/check_in/models/complaint.dart';
import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// "Composed around" and the complaint, with each finding added since.
class const ComposedAround({
  super.key,

  /// The complaint as it stands.
  required final Complaint complaint,
}) extends StatelessWidget {
  /// Creates "Composed around" and the complaint
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      crossAxisAlignment: .center,
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: [
        Text(
          'Composed around',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        PillChip(
          label: complaint.presentingText,
          color: theme.colorScheme.primaryContainer,
          foreground: theme.colorScheme.onPrimaryContainer,
          prominent: true,
        ),
        for (final addendum in complaint.addenda)
          PillChip(
            label: addendum,
            color: theme.colorScheme.surface,
            prominent: true,
          ),
      ],
    );
  }
}
