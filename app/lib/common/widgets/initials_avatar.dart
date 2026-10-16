import 'package:flutter/material.dart';

/// A round badge with a person's initials, e.g. `MC` or `R` for a doctor.
class const InitialsAvatar({
  super.key,

  /// The name the initials come from; titles such as `Dr.` are skipped.
  required final String name,

  /// Fill; the theme's lavender when `null`.
  final Color? color,

  /// Diameter of the badge.
  final double size = _defaultSize,
}) extends StatelessWidget {
  static const double _defaultSize = 44.0;
  static const double _textShare = 0.36;

  /// The first letters of the first and last words, `Dr.` and the like
  /// left out.
  String get initials {
    final List<String> words = name
        .split(' ')
        .where((word) => word.isNotEmpty && !word.endsWith('.'))
        .toList();
    if (words.isEmpty) return '';
    final String first = words.first.characters.first;

    return words.length == 1
        ? first.toUpperCase()
        : '$first${words.last.characters.first}'.toUpperCase();
  }

  /// Creates an avatar.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? theme.colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            initials,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: size * _textShare,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
