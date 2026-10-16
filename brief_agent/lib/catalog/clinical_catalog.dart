import 'dart:convert';

import 'package:a2ui_agent/a2ui_agent.dart';
import 'package:a2ui_core/a2ui_core.dart';
import 'package:brief_agent/catalog/clinical_catalog_document.g.dart';
import 'package:brief_agent/catalog/transformers/child_lists_marked.dart';
import 'package:brief_agent/catalog/transformers/key_values_described.dart';
import 'package:brief_agent/catalog/transformers/required_properties_first.dart';
import 'package:brief_agent/common/utils/json_fields.dart';

/// The catalog the app renders briefs with, as this agent registers it.
abstract final class ClinicalCatalog {
  /// The catalog with the transformers the Express prompt needs.
  ///
  /// Throws [StateError] while the document is the placeholder, which has
  /// no components.
  static CatalogConfig config() {
    final CatalogApi catalog = Catalog.fromJson(
      JsonFields.asObject(
        jsonDecode(ClinicalCatalogDocument.json),
        'catalog document',
      ),
    );
    if (catalog.components.isEmpty) {
      throw StateError(
        'The catalog document is a placeholder. From app/, run '
        'UPDATE_AGENT_CATALOG=1 flutter test test/agent_catalog_test.dart',
      );
    }

    return CatalogConfig(
      catalog,
      transformers: const <CatalogTransformer>[
        ChildListsMarked(),
        RequiredPropertiesFirst(),
        KeyValuesDescribed(),
      ],
    );
  }
}
