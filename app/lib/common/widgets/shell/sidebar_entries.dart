import 'package:clinical_brief/common/models/shell_section.dart';
import 'package:clinical_brief/common/routes/app_routes.dart';
import 'package:clinical_brief/common/widgets/section_label.dart';
import 'package:clinical_brief/common/widgets/shell/app_brand.dart';
import 'package:clinical_brief/common/widgets/shell/sidebar_nav_item.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The brand and the entries, top down.
class const SidebarEntries({
  super.key,

  /// The section the current screen belongs to.
  required final ShellSection section,

  /// Who the brief is for, shown under its entry.
  final String? briefLabel,
}) extends StatelessWidget {
  /// Creates a sidebar entry
  this;

  @override
  Widget build(BuildContext context) {
    final isBrief = section == .brief;

    return Column(
      crossAxisAlignment: .start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: AppSpacing.sm),
          child: AppBrand(),
        ),
        const SizedBox(height: AppSpacing.xxl),
        const SectionLabel.group('Front desk'),
        SidebarNavItem(
          icon: Icons.grid_view_rounded,
          label: 'Check-in',
          selected: section == .checkIn,
          // Back to the list, however deep the brief was opened.
          onTap: section == .checkIn
              ? null
              : () => context.go(AppRoutes.checkIn),
        ),
        if (isBrief) ...[
          const SizedBox(height: AppSpacing.xl),
          const SectionLabel.group('Consultation'),
          SidebarNavItem(
            icon: Icons.description_outlined,
            label: 'Brief',
            detail: briefLabel,
            selected: true,
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        const SectionLabel.group('Reference'),
        SidebarNavItem(
          icon: Icons.widgets_outlined,
          label: 'Catalog',
          selected: section == .catalog,
          onTap: section == .catalog
              ? null
              : () => context.go(AppRoutes.catalog),
        ),
      ],
    );
  }
}
