import 'package:flutter/material.dart';

/// The round help button for the presenter's demo case.
class const DemoCaseButton({
  super.key,

  /// Opens the demo case.
  required final VoidCallback onPressed,
}) extends StatelessWidget {
  static const _iconSize = 20.0;

  /// Creates the button.
  this;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Muted: a presenter's aid, not part of the record.
    return IconButton(
      tooltip: 'Demo case',
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurfaceVariant,
      ),
      icon: const Icon(Icons.help_outline, size: _iconSize),
    );
  }
}
