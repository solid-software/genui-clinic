import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// One entry: lavender when it is where you are.
class const SidebarNavItem({
  super.key,

  /// The entry's icon.
  required final IconData icon,

  /// The entry's name.
  required final String label,

  /// Whether the entry is where you are.
  required final bool selected,

  /// Optional line under the name, e.g. the patient's name.
  final String? detail,

  /// Called on tap; the entry is inert when `null`.
  final VoidCallback? onTap,
}) extends StatelessWidget {
  static const _iconSize = 20.0;

  /// Creates a sidebar navigation item
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final corners = BorderRadius.circular(AppSpacing.tileRadius);
    final detail = this.detail;

    return Material(
      color: selected ? theme.colorScheme.primaryContainer : Colors.transparent,
      borderRadius: corners,
      child: InkWell(
        borderRadius: corners,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Icon(icon, size: _iconSize),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: .w500,
                      ),
                    ),
                    if (detail != null)
                      Text(
                        detail,
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: theme.mutedBodySmall,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
