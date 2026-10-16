import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

/// States that nothing here is real, and who made it.
///
/// Aligned by the surrounding [DefaultTextStyle]: start in the sidebar,
/// centred under narrow content.
class const DemoDisclaimer({
  super.key,
  final TextAlign? textAlign,
  final String? customText,
}) extends StatelessWidget {
  static final Uri _authorSite = Uri.parse('https://solid.software/');

  /// Creates the disclaimer.
  this;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle? style = theme.mutedBodySmall;

    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(
            text:
                customText ??
                'Demo project. All patients, records and results are '
                    'fictional and do not describe real people. Not for '
                    'clinical use. Made by ',
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            // Link makes a real web anchor, so new-tab and copy-link work.
            child: Link(
              uri: _authorSite,
              target: LinkTarget.blank,
              builder: (_, followLink) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: followLink,
                  child: Text(
                    'Solid Software',
                    style: style?.copyWith(
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: textAlign,
    );
  }
}
