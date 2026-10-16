import 'package:clinical_brief/medical_catalog/widgets/layout/section_stack.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Two columns of sections side by side, stacked on a narrow screen.
class const SplitSection({
  super.key,

  /// Sections for the wider, leading column.
  required final List<Widget> primary,

  /// Sections for the narrower, trailing column.
  required final List<Widget> secondary,
}) extends StatelessWidget {
  static const double _twoColumnMinWidth = 720.0;

  /// Creates a split section.
  this;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (_, constraints) => constraints.maxWidth >= _twoColumnMinWidth
        ? Row(
            crossAxisAlignment: .start,
            spacing: AppSpacing.cardGap,
            children: [
              Expanded(flex: 3, child: SectionStack(children: primary)),
              Expanded(flex: 2, child: SectionStack(children: secondary)),
            ],
          )
        : SectionStack(children: [...primary, ...secondary]),
  );
}
