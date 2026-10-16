import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/common/widgets/panel_card.dart';
import 'package:clinical_brief/common/widgets/pill_chip.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// The container every generated section sits in: a rounded panel with an
/// icon, the model's title and its annotation as a pill.
class const SectionCard({
  super.key,

  /// The body of the card.
  required final Widget child,

  /// Optional heading, e.g. `Relevant history`.
  final String? title,

  /// Optional annotation at the end of the heading, e.g. `6 medicines`.
  final String? trailing,

  /// Optional sub-heading, e.g. `4 results, 4 different doctors`.
  final String? caption,

  /// Optional muted line under the body, e.g. `Nothing since.`.
  final String? footnote,

  /// The icon before the heading, chosen by the component, not the model.
  final IconData? icon,

  /// How much attention the card should draw.
  final ClinicalTone tone = ClinicalTone.neutral,
}) extends StatelessWidget {
  /// Creates a section card.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isNeutral = tone == ClinicalTone.neutral;
    final String? annotation = trailing;
    final String? note = footnote;
    // Without a heading there is no header to put the caption under.
    final String? bodyCaption = title == null ? caption : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.cardGap),
      child: PanelCard(
        title: title,
        subtitle: caption,
        icon: icon,
        color: isNeutral ? null : tone.backgroundOf(context),
        accent: isNeutral ? null : tone.foregroundOf(context),
        trailing: annotation == null
            ? null
            : PillChip(
                label: annotation,
                color: isNeutral ? null : theme.colorScheme.surface,
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (bodyCaption != null)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Text(bodyCaption, style: theme.mutedBodyMedium),
              ),
            child,
            if (note != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.md),
                child: Text(note, style: theme.mutedBodyMedium),
              ),
          ],
        ),
      ),
    );
  }
}
