import 'dart:convert';
import 'dart:io';

import 'package:clinical_brief/medical_catalog/medical_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

/// Keeps the brief agent's copy of the catalog in step with the app's.
///
/// The agent registers the catalog the app renders; it cannot build it from
/// the widgets, so it reads a document this test writes.
void main() {
  test('the agent registers the catalog the app renders', () {
    final File document = File(_AgentCatalog.path);
    final String expected = _AgentCatalog.source();
    if (Platform.environment.containsKey(_AgentCatalog.updateVariable)) {
      document.writeAsStringSync(expected);
    }

    expect(
      document.readAsStringSync(),
      expected,
      reason:
          "The agent's catalog is out of date. From app/, run "
          '${_AgentCatalog.command}, then deploy the agent again.',
    );
  });
}

/// The generated Dart file that holds the catalog document.
abstract final class _AgentCatalog {
  static const String path =
      '../brief_agent/lib/catalog/clinical_catalog_document.g.dart';
  static const String updateVariable = 'UPDATE_AGENT_CATALOG';
  static const String command =
      '$updateVariable=1 flutter test test/agent_catalog_test.dart';

  static const String _rawQuote = "r'''";
  static const String _quote = "'''";

  /// The file's contents for the catalog as the app builds it now.
  static String source() {
    final String json = const JsonEncoder.withIndent(
      '  ',
    ).convert(MedicalCatalog.build().toCapabilitiesJson());
    if (json.contains(_quote)) {
      throw StateError('The catalog contains $_quote; it cannot be embedded.');
    }

    return "// Generated from the app's catalog by "
        'test/agent_catalog_test.dart; do not\n'
        '// edit. To regenerate, from app/:\n'
        '//\n'
        '//   $command\n'
        '\n'
        "/// The app's catalog as an A2UI catalog document.\n"
        'abstract final class ClinicalCatalogDocument {\n'
        '  /// The document, as JSON.\n'
        '  static const String json = $_rawQuote\n'
        '$json\n'
        '$_quote;\n'
        '}\n';
  }
}
