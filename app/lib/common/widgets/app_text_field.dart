import 'package:clinical_brief/common/enums/app_text_field_shape.dart';
import 'package:clinical_brief/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The app's text field, in the three shapes it takes.
class AppTextField extends StatelessWidget {
  static final _pill = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
    borderSide: .none,
  );

  /// Holds the text, so it outlives the field when its parent rebuilds.
  final TextEditingController controller;

  /// Greyed text shown while the field is empty.
  final String? hintText;

  /// Name of the field, shown above the text once there is some.
  final String? labelText;

  /// Whether input is accepted; the field decides when `null`.
  final bool? enabled;

  /// Whether the field takes the keyboard focus when it appears.
  final bool autofocus;

  /// Lines the field shows when empty; one when `null`.
  final int? minLines;

  /// Lines the field grows to before it scrolls.
  final int maxLines;

  /// Called with the text as it is typed.
  final ValueChanged<String>? onChanged;

  /// Called with the text when the keyboard's action key is pressed.
  final ValueChanged<String>? onSubmitted;

  final AppTextFieldShape _shape;

  /// A pill with a search icon, searching as it is typed into.
  const AppTextField.search({
    super.key,
    required this.controller,
    required this.hintText,
    required ValueChanged<String> this.onChanged,
  }) : labelText = null,
       enabled = null,
       autofocus = false,
       minLines = null,
       maxLines = 1,
       onSubmitted = null,
       _shape = .search;

  /// No border or fill, for a field drawn inside its own container. Grows
  /// from one line to [maxLines]; the keyboard's send key submits.
  const AppTextField.bare({
    super.key,
    required this.controller,
    required this.hintText,
    required this.enabled,
    required this.maxLines,
    required ValueChanged<String> this.onSubmitted,
  }) : labelText = null,
       autofocus = false,
       minLines = 1,
       onChanged = null,
       _shape = .bare;

  /// A labelled, outlined box for a few lines of free text.
  const AppTextField.multiline({
    super.key,
    required this.controller,
    required this.labelText,
    required this.minLines,
    required this.maxLines,
    this.hintText,
    this.autofocus = false,
  }) : enabled = null,
       onChanged = null,
       onSubmitted = null,
       _shape = .outlined;

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    enabled: enabled,
    autofocus: autofocus,
    minLines: minLines,
    maxLines: maxLines,
    textCapitalization: _shape == .search ? .none : .sentences,
    // A plain-text keyboard makes Enter send instead of adding a line, on
    // web, desktop and phones.
    keyboardType: _shape == .bare ? .text : null,
    textInputAction: switch (_shape) {
      .search => .search,
      .bare => .send,
      .outlined => null,
    },
    onChanged: onChanged,
    onSubmitted: onSubmitted,
    decoration: _decoration(Theme.of(context)),
  );

  InputDecoration _decoration(ThemeData theme) => switch (_shape) {
    .search => InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(
        Icons.search,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      border: _pill,
      enabledBorder: _pill,
      focusedBorder: _pill.copyWith(
        borderSide: BorderSide(color: theme.colorScheme.primary),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
    ),
    .bare => InputDecoration(
      hintText: hintText,
      filled: false,
      border: .none,
      enabledBorder: .none,
      focusedBorder: .none,
      disabledBorder: .none,
    ),
    .outlined => InputDecoration(
      labelText: labelText,
      hintText: hintText,
      alignLabelWithHint: true,
    ),
  };
}
