import 'package:clinical_brief/common/widgets/app_text_field.dart';
import 'package:clinical_brief/dashboard/widgets/header/send_button.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The field the doctor types into mid-exam, under the complaint chips: a
/// white field with a round send button inside it.
class const RefineField({
  super.key,

  /// Called with the text the doctor added.
  required final ValueChanged<String> onSubmit,

  /// Whether input is accepted; off while the model is composing.
  required final bool enabled,
}) extends StatefulWidget {
  static const int _maxLines = 3;
  static const double _innerPadding = 6.0;
  static const Color _shadow = Color(0x143B2C86);
  static const double _shadowBlur = 24.0;
  static const Offset _shadowOffset = Offset(0.0, 8.0);

  /// Creates the field.
  this;

  @override
  State<RefineField> createState() => _RefineFieldState();
}

class _RefineFieldState extends State<RefineField> {
  final TextEditingController _finding = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.tileRadius),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: RefineField._shadow,
            blurRadius: RefineField._shadowBlur,
            offset: RefineField._shadowOffset,
          ),
        ],
      ),
      // The right inset matches the gap above and below the button.
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          RefineField._innerPadding,
          AppSpacing.md,
          RefineField._innerPadding,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: AppTextField.bare(
                controller: _finding,
                hintText: 'Refine: add what you found, or new readings',
                enabled: widget.enabled,
                maxLines: RefineField._maxLines,
                onSubmitted: (_) => _submit(),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            // Live only once there is something to send.
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _finding,
              builder: (_, value, _) => SendButton(
                isBusy: !widget.enabled,
                onPressed: widget.enabled && value.text.trim().isNotEmpty
                    ? _submit
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _finding.dispose();
    super.dispose();
  }

  void _submit() {
    final String text = _finding.text.trim();
    if (text.isEmpty) {
      return;
    }

    _finding.clear();
    widget.onSubmit(text);
  }
}
