import 'package:clinical_brief/catalog_browser/widgets/catalog_json_block.dart';
import 'package:clinical_brief/common/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';

/// The whole catalog as JSON, as the brief agent is told of it.
class const CatalogJsonDialog({
  super.key,

  /// The catalog's JSON.
  required final JsonMap json,
}) extends StatelessWidget {
  static const _width = 720.0;

  /// Creates the dialog.
  this;

  /// Shows the dialog.
  static Future<void> show(BuildContext context, JsonMap json) => showDialog(
    context: context,
    builder: (_) => CatalogJsonDialog(json: json),
  );

  @override
  Widget build(BuildContext context) => AppDialog(
    title: 'Catalog JSON',
    width: _width,
    closeLabel: 'Close',
    content: CatalogJsonBlock(json: json),
  );
}
