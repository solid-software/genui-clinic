import 'package:clinical_brief/auth/services/auth_manager.dart';
import 'package:clinical_brief/common/di/service_locator.dart';
import 'package:clinical_brief/common/models/shell_section.dart';
import 'package:clinical_brief/common/widgets/shell/sidebar_entries.dart';
import 'package:clinical_brief/common/widgets/shell/sidebar_nav_item.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The navigation column on wide screens: the brand, where you are, and an
/// optional footer at the bottom.
class const AppSidebar({
  super.key,

  /// The section the current screen belongs to.
  required final ShellSection section,

  /// Who the brief is for, shown under its entry.
  final String? briefLabel,

  /// Optional widget pinned to the bottom, e.g. the demo disclaimer.
  final Widget? footer,
}) extends StatelessWidget {
  /// Width of the column.
  static const double width = 248.0;

  /// Creates the sidebar.
  this;

  @override
  Widget build(BuildContext context) {
    final footer = this.footer;

    return Container(
      width: width,
      color: Theme.of(context).colorScheme.surface,
      // At least the window's height, so the footer sits at the bottom; on
      // a very short window the column scrolls instead.
      child: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          primary: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xxl,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .spaceBetween,
                spacing: AppSpacing.xl,
                children: [
                  SidebarEntries(section: section, briefLabel: briefLabel),
                  Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    spacing: AppSpacing.xl,
                    children: [
                      SidebarNavItem(
                        icon: Icons.logout,
                        label: 'Sign out',
                        selected: false,
                        onTap: ServiceLocator.get<AuthManager>().signOut,
                      ),
                      if (footer != null)
                        Padding(
                          padding: const EdgeInsets.only(left: AppSpacing.sm),
                          child: footer,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
