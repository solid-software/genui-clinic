import 'package:flutter/material.dart';

/// Text styles the app uses on top of the theme's own.
extension AppTextStyles on ThemeData {
  /// Small secondary text: captions, footnotes, metadata.
  TextStyle? get mutedBodySmall =>
      textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant);

  /// Body-size secondary text.
  TextStyle? get mutedBodyMedium =>
      textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant);
}
