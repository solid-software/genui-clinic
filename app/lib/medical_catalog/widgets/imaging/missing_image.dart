import 'package:flutter/material.dart';

/// What shows in place of an image the app does not have.
class const MissingImage({super.key}) extends StatelessWidget {
  /// Creates the placeholder.
  this;

  @override
  Widget build(BuildContext context) => const Center(
    child: Icon(Icons.image_not_supported_outlined, color: Colors.white54),
  );
}
