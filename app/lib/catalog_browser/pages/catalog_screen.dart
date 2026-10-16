import 'package:clinical_brief/catalog_browser/services/catalog_previews.dart';
import 'package:clinical_brief/catalog_browser/state/catalog_browser_controller.dart';
import 'package:clinical_brief/catalog_browser/widgets/catalog_body.dart';
import 'package:clinical_brief/common/widgets/shell/app_shell.dart';
import 'package:clinical_brief/common/widgets/shell/demo_disclaimer.dart';
import 'package:clinical_brief/medical_catalog/medical_catalog.dart';
import 'package:flutter/material.dart';

/// The catalog page: every component the brief agent can use, drawn live,
/// and the functions they can call.
class const CatalogScreen({super.key}) extends StatefulWidget {
  /// Creates the catalog screen.
  this;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late final _catalog = MedicalCatalog.build();
  late final _controller = CatalogBrowserController.of(_catalog);
  late final _previews = CatalogPreviews.of(_catalog);
  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) => AppShell(
    section: .catalog,
    footer: const DemoDisclaimer(),
    child: ListenableBuilder(
      listenable: _controller,
      builder: (_, _) => CatalogBody(
        controller: _controller,
        previews: _previews,
        search: _search,
      ),
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    _previews.dispose();
    _search.dispose();
    super.dispose();
  }
}
