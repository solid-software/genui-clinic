import 'package:clinical_brief/common/widgets/shell/app_brand.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The brand above the content, for phone and tablet widths.
class const ShellNarrowFrame({
  super.key,

  /// The screen's content.
  required final Widget child,

  /// Optional note under the content.
  final Widget? footer,
}) extends StatelessWidget {
  /// Creates shell narrow frame.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final footer = this.footer;

    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              0.0,
            ),
            child: AppBrand(style: theme.textTheme.titleLarge),
          ),
          Expanded(child: child),
          if (footer != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: DefaultTextStyle.merge(
                textAlign: .center,
                child: footer,
              ),
            ),
        ],
      ),
    );
  }
}
