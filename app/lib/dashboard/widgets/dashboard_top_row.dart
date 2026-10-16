import 'package:clinical_brief/common/routes/app_routes.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Back to the list, and the page title.
class const DashboardTopRow({super.key}) extends StatelessWidget {
  /// Creates dashboard top row
  this;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      OutlinedButton.icon(
        // Not a pop: a brief opened from a link has no list under it.
        onPressed: () => context.go(AppRoutes.checkIn),
        style: OutlinedButton.styleFrom(side: .none),
        icon: const Icon(Icons.arrow_back),
        label: const Text('Check-in'),
      ),
      const SizedBox(width: AppSpacing.lg),
      Text('Brief', style: Theme.of(context).textTheme.headlineSmall),
    ],
  );
}
