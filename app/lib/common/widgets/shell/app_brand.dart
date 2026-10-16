import 'package:flutter/material.dart';

/// The app's name, "GenUI Clinic", with the second word in the accent.
class const AppBrand({
  super.key,

  /// Text style; the theme's small headline when `null`.
  final TextStyle? style,
}) extends StatelessWidget {
  /// Creates the brand.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Text.rich(
      TextSpan(
        style: style ?? theme.textTheme.headlineSmall,
        children: <InlineSpan>[
          const TextSpan(text: 'GenUI '),
          TextSpan(
            text: 'Clinic',
            style: TextStyle(color: theme.colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
