import 'package:clinical_brief/medical_catalog/items/bar_comparison_item.dart';
import 'package:clinical_brief/medical_catalog/items/care_gap_list_item.dart';
import 'package:clinical_brief/medical_catalog/items/chart_group_item.dart';
import 'package:clinical_brief/medical_catalog/items/ecg_strip_item.dart';
import 'package:clinical_brief/medical_catalog/items/fact_list_item.dart';
import 'package:clinical_brief/medical_catalog/items/imaging_timeline_item.dart';
import 'package:clinical_brief/medical_catalog/items/lab_panel_item.dart';
import 'package:clinical_brief/medical_catalog/items/measurement_row_item.dart';
import 'package:clinical_brief/medical_catalog/items/medication_table_item.dart';
import 'package:clinical_brief/medical_catalog/items/safety_banner_item.dart';
import 'package:clinical_brief/medical_catalog/items/section_grid_item.dart';
import 'package:clinical_brief/medical_catalog/items/split_section_item.dart';
import 'package:clinical_brief/medical_catalog/items/trend_chart_item.dart';
import 'package:clinical_brief/medical_catalog/items/xray_image_item.dart';
import 'package:genui/genui.dart';

/// The brief's catalog: the medical cards and a few basic items, kept few so
/// the model spends its effort on what to show.
abstract final class MedicalCatalog {
  /// The id the catalog is registered under.
  static const String _id = 'com.clinicalbrief.catalog.v1';

  /// Builds the catalog.
  ///
  /// The app names it in every request to the brief agent; how a brief is
  /// composed from it is the agent's part, in brief_agent/.
  static Catalog build() => BasicCatalogItems.asCatalog()
      .copyWithout(
        itemsToRemove: [
          BasicCatalogItems.audioPlayer,
          BasicCatalogItems.video,
          BasicCatalogItems.image,
          BasicCatalogItems.slider,
          BasicCatalogItems.dateTimeInput,
          BasicCatalogItems.textField,
          BasicCatalogItems.checkBox,
          BasicCatalogItems.modal,
          BasicCatalogItems.tabs,
          BasicCatalogItems.choicePicker,
        ],
      )
      .copyWith(
        catalogId: _id,
        newItems: [
          SafetyBannerItem.item,
          TrendChartItem.item,
          MeasurementRowItem.item,
          ImagingTimelineItem.item,
          XRayImageItem.item,
          MedicationTableItem.item,
          CareGapListItem.item,
          LabPanelItem.item,
          BarComparisonItem.item,
          EcgStripItem.item,
          SplitSectionItem.item,
          SectionGridItem.item,
          ChartGroupItem.item,
          FactListItem.item,
        ],
      );
}
