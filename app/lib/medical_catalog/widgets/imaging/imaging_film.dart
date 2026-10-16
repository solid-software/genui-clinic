import 'dart:async';

import 'package:clinical_brief/medical_catalog/widgets/imaging/missing_image.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// One image from the record on a black panel, opened full screen on tap.
class const ImagingFilm({
  super.key,

  /// Asset path of the image, as given in the record.
  required final String image,

  /// Height of the panel.
  required final double height,
}) extends StatelessWidget {
  /// Folder of the bundled record images; other paths show a placeholder.
  static const String _assetFolder = 'assets/imaging/';

  static const String _chestXRays = 'NIH Clinical Center, ChestX-ray dataset';
  static const String _ctSlices = 'NIH Clinical Center, DeepLesion dataset';

  /// Source of each bundled image.
  ///
  /// Kept in code, not left to the model, so a credit is never optional.
  static const Map<String, String> _credits = <String, String>{
    'assets/imaging/john_miller_chest_2021.png': _chestXRays,
    'assets/imaging/margaret_collins_chest_2024.png': _chestXRays,
    'assets/imaging/patricia_evans_chest_2024.png': _chestXRays,
    'assets/imaging/margaret_collins_ct_abdomen_2017.png': _ctSlices,
    'assets/imaging/patricia_evans_ct_chest_2021.png': _ctSlices,
  };

  static const double _zoomMax = 4.0;
  static const Color _filmColor = Color(0xFF000000);

  /// Creates a film panel.
  this;

  /// The line crediting [image]'s source, or `null` for an unknown image.
  static String? creditFor(String image) {
    final String? source = _credits[image];

    return source == null ? null : 'Sample image: $source';
  }

  @override
  Widget build(BuildContext context) => Material(
    color: _filmColor,
    borderRadius: BorderRadius.circular(AppSpacing.sm),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () => unawaited(_openFull(context)),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: _picture(),
      ),
    ),
  );

  /// The image, or a placeholder for an unknown path, so a wrong path from
  /// the model cannot break the brief.
  Widget _picture() => image.startsWith(_assetFolder)
      ? Image.asset(
          image,
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => const MissingImage(),
        )
      : const MissingImage();

  Future<void> _openFull(BuildContext context) => showDialog<void>(
    context: context,
    builder: (dialogContext) => Dialog(
      backgroundColor: _filmColor,
      insetPadding: const EdgeInsets.all(AppSpacing.xl),
      child: Stack(
        children: <Widget>[
          InteractiveViewer(
            maxScale: _zoomMax,
            child: Center(child: _picture()),
          ),
          Positioned(
            top: AppSpacing.sm,
            right: AppSpacing.sm,
            child: IconButton(
              tooltip: 'Close',
              color: Colors.white,
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ),
        ],
      ),
    ),
  );
}
