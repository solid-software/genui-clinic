import 'package:clinical_brief/common/models/clinical_tone.dart';
import 'package:clinical_brief/medical_catalog/models/fact_entry.dart';
import 'package:clinical_brief/medical_catalog/widgets/safety/safety_banner_entry.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Band at the top of a brief: allergies, drugs and anticoagulation.
///
/// A value listing three or more items, such as the active medication, is
/// shown as chips beside the single values; anything else in large type.
class const SafetyBanner({
  super.key,

  /// Columns to show, normally allergies, medication and anticoagulation.
  required final List<FactEntry> entries,

  /// How much attention the band should draw.
  final ClinicalTone tone = ClinicalTone.critical,
}) extends StatelessWidget {
  static const double _twoColumnMinWidth = 720.0;
  static const int _singlesFlex = 2;
  static const int _listsFlex = 3;

  /// Creates a safety banner.
  this;

  @override
  Widget build(BuildContext context) {
    final Color accent = tone.foregroundOf(context);
    final List<Widget> singles = <Widget>[
      for (final FactEntry entry in entries)
        if (SafetyBannerEntry.itemsOf(entry).length <
            SafetyBannerEntry.minListItems)
          SafetyBannerEntry(entry: entry, accent: accent),
    ];
    final List<Widget> lists = <Widget>[
      for (final FactEntry entry in entries)
        if (SafetyBannerEntry.itemsOf(entry).length >=
            SafetyBannerEntry.minListItems)
          SafetyBannerEntry(entry: entry, accent: accent),
    ];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.cardGap),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        AppSpacing.xl,
        AppSpacing.xxl,
        AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: tone.backgroundOf(context),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: LayoutBuilder(
        builder: (_, constraints) =>
            constraints.maxWidth >= _twoColumnMinWidth &&
                singles.isNotEmpty &&
                lists.isNotEmpty
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.xxl,
                children: <Widget>[
                  Expanded(
                    flex: _singlesFlex,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: singles,
                    ),
                  ),
                  Expanded(
                    flex: _listsFlex,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: lists,
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (final FactEntry entry in entries)
                    SafetyBannerEntry(entry: entry, accent: accent),
                ],
              ),
      ),
    );
  }
}
