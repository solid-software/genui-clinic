import 'package:clinical_brief/check_in/models/clinical_record.dart';
import 'package:clinical_brief/common/utils/date_formatting.dart';
import 'package:clinical_brief/common/widgets/icon_tile.dart';
import 'package:clinical_brief/common/widgets/section_label.dart';
import 'package:clinical_brief/dashboard/widgets/full_record/record_card.dart';
import 'package:clinical_brief/dashboard/widgets/full_record/record_row.dart';
import 'package:clinical_brief/dashboard/widgets/full_record/series_card.dart';
import 'package:clinical_brief/medical_catalog/widgets/layout/chart_grid.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The whole chart, collapsed under the brief.
///
/// Built by the app, not the model, so everything on file is one tap away.
class const FullRecordSection({
  super.key,

  /// The chart to show.
  required final ClinicalRecord record,
}) extends StatelessWidget {
  /// Creates full record section.
  this;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.cardGap),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          // The lazy list disposes this tile off screen; the page storage
          // key restores whether it was open.
          key: PageStorageKey('full-record-${record.patientId}'),
          shape: const Border(),
          tilePadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.sm,
          ),
          leading: const IconTile(icon: Icons.folder_open_outlined),
          title: Text(
            'Everything in the record \u2014 ${record.entryCount} entries',
            style: theme.textTheme.titleMedium,
          ),
          subtitle: Text(
            'Nothing hidden, including what is ranked above',
            style: theme.textTheme.bodyMedium?.copyWith(color: muted),
          ),
          // The default centres children, floating narrow content mid-card.
          expandedAlignment: .topLeft,
          expandedCrossAxisAlignment: .stretch,
          childrenPadding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.xl,
            AppSpacing.lg,
          ),
          children: [
            ChartGrid(children: _groupCards(record)),
            if (record.observations.isNotEmpty) ...[
              const SectionLabel.overline('Readings'),
              ChartGrid(
                children: [
                  for (final series in record.observations)
                    SeriesCard(series: series),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  static List<Widget> _groupCards(ClinicalRecord record) => [
    RecordCard(
      title: 'Allergies',
      rows: record.allergies.isEmpty
          ? const [RecordRow(label: 'None known')]
          : [
              for (final allergy in record.allergies) RecordRow(label: allergy),
            ],
    ),
    RecordCard(
      title: 'Medication',
      rows: [
        for (final drug in record.medications)
          RecordRow(
            label: drug.label,
            detail: drug.schedule,
            trailing: drug.isAnticoagulant ? 'Anticoagulant' : null,
            trailingTone: .critical,
          ),
      ],
    ),
    RecordCard(
      title: 'Conditions',
      rows: [
        for (final condition in record.conditions)
          RecordRow(
            label: condition.name,
            detail: condition.detail,
            trailing: 'since ${condition.since}',
          ),
      ],
    ),
    RecordCard(
      title: 'Risk factors',
      rows: [
        for (final factor in record.riskFactors)
          RecordRow(
            label: factor.name,
            detail: factor.detail,
            trailing: 'recorded ${factor.lastRecordedYear}',
          ),
      ],
    ),
    RecordCard(
      title: 'Imaging',
      rows: [
        for (final study in record.imaging)
          RecordRow(
            label: study.modality,
            detail: study.conclusion,
            trailing: DateFormatting.monthYear(study.takenAt),
            image: study.image,
          ),
      ],
    ),
  ].where((card) => card.rows.isNotEmpty).toList();
}
