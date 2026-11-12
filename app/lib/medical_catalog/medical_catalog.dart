import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:a2ui_flutter/basic_catalog.dart';
import 'package:clinical_brief/medical_catalog/items/bar_comparison_item.dart';
import 'package:clinical_brief/medical_catalog/items/care_gap_list_item.dart';
import 'package:clinical_brief/medical_catalog/items/catalog_item_factory.dart';
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

/// The brief's catalog: the medical cards and a few basic items, kept few so
/// the model spends its effort on what to show.
abstract final class MedicalCatalog {
  /// The id the catalog is registered under.
  static const String _id = 'com.clinicalbrief.catalog.v1';

  /// Builds the catalog.
  ///
  /// The app names it in every request to the brief agent; how a brief is
  /// composed from it is the agent's part, in brief_agent/.
  static CatalogImplementation build() {
    _registerBasicExamples();

    return basicCatalog().derive(
      catalogId: _id,
      components: BasicComponents.all.map((c) => c.name).toSet().difference({
        BasicComponents.audioPlayer.name,
        BasicComponents.video.name,
        BasicComponents.image.name,
        BasicComponents.slider.name,
        BasicComponents.dateTimeInput.name,
        BasicComponents.textField.name,
        BasicComponents.checkBox.name,
        BasicComponents.modal.name,
        BasicComponents.tabs.name,
        BasicComponents.choicePicker.name,
      }),
      addComponents: [
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
      instructions: BasicComponents.api.instructions,
    );
  }

  /// Examples for the kept basic components for catalog browser.
  static void _registerBasicExamples() {
    CatalogItemFactory.examples.addAll(const {
      'Divider': '[{"id": "divider", "component": "Divider"}]',
      'Icon': '[{"id": "icon", "component": "Icon", "name": "star"}]',
      'Text': '[{"id": "text", "component": "Text", "text": "Example text"}]',
      'Button': '''
        [
          {
            "id": "button",
            "component": "Button",
            "child": "buttonLabel",
            "action": {"event": {"name": "tap"}}
          },
          {"id": "buttonLabel", "component": "Text", "text": "Button"}
        ]
      ''',
      'Card': '''
        [
          {"id": "card", "component": "Card", "child": "cardText"},
          {"id": "cardText", "component": "Text", "text": "Card content"}
        ]
      ''',
      'Column': '''
        [
          {
            "id": "column",
            "component": "Column",
            "children": ["columnText1", "columnText2"]
          },
          {"id": "columnText1", "component": "Text", "text": "First"},
          {"id": "columnText2", "component": "Text", "text": "Second"}
        ]
      ''',
      'Row': '''
        [
          {
            "id": "row",
            "component": "Row",
            "children": ["rowText1", "rowText2"]
          },
          {"id": "rowText1", "component": "Text", "text": "First"},
          {"id": "rowText2", "component": "Text", "text": "Second"}
        ]
      ''',
      'List': '''
        [
          {
            "id": "list",
            "component": "List",
            "children": ["listText1", "listText2", "listText3"]
          },
          {"id": "listText1", "component": "Text", "text": "Item 1"},
          {"id": "listText2", "component": "Text", "text": "Item 2"},
          {"id": "listText3", "component": "Text", "text": "Item 3"}
        ]
      ''',
    });
  }
}
