import 'package:flutter/material.dart';

/// How much attention the model says a piece of information should draw.
enum ClinicalTone {
  /// Ordinary information.
  neutral,

  /// Worth a second look.
  warning,

  /// Safety critical, e.g. allergies or anticoagulation.
  critical;

  /// The values a JSON schema `enum` allows.
  static List<String> get wireNames => values.map((tone) => tone.name).toList();

  /// Parses a model value, falling back to [neutral].
  static ClinicalTone fromWire(Object? wireName) =>
      values.asNameMap()[wireName] ?? neutral;

  /// Colour for text and strokes.
  Color foregroundOf(BuildContext context) => switch (this) {
    ClinicalTone.neutral => Theme.of(context).colorScheme.onSurface,
    ClinicalTone.warning => const Color(0xFFA85A06),
    ClinicalTone.critical => const Color(0xFFA8172A),
  };

  /// Colour for container fills.
  Color backgroundOf(BuildContext context) => switch (this) {
    ClinicalTone.neutral => Theme.of(context).colorScheme.surface,
    ClinicalTone.warning => const Color(0xFFFDF1DE),
    ClinicalTone.critical => const Color(0xFFFBE4E8),
  };

  /// Colour for lines, bars and dots: the theme's accent when neutral.
  Color accentOf(BuildContext context) => this == ClinicalTone.neutral
      ? Theme.of(context).colorScheme.primary
      : foregroundOf(context);
}
