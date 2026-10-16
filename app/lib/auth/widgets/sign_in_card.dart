import 'package:clinical_brief/auth/services/auth_manager.dart';
import 'package:clinical_brief/auth/widgets/google_sign_in_button.dart';
import 'package:clinical_brief/common/di/service_locator.dart';
import 'package:clinical_brief/common/widgets/shell/app_brand.dart';
import 'package:clinical_brief/common/widgets/shell/demo_disclaimer.dart';
import 'package:clinical_brief/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Asks to sign in with Google; the scope opens once signed in.
class SignInCard extends StatefulWidget {
  /// Constructor.
  const SignInCard();

  @override
  State<SignInCard> createState() => _SignInCardState();
}

class _SignInCardState extends State<SignInCard> {
  var _busy = false;
  String? _error;

  @override
  Widget build(BuildContext context) => Card(
    child: Container(
      constraints: const BoxConstraints(maxWidth: 360),
      padding: const .all(24),
      child: Column(
        mainAxisSize: .min,
        spacing: 16,
        children: [
          const AppBrand(),
          const DemoDisclaimer(
            customText:
                'GenUI clinic is a demo of Generative UI, '
                'where the interface is composed on the fly by Gemini, '
                'based on patient history and reason for a visit. '
                'Health professionals can understand '
                'patient history more quickly '
                'and ensure that the data displayed is accurate. '
                '\n\n'
                'All patients, records, '
                'and results are fictional and do not describe real people. '
                'Not for clinical use. Made by Solid Software.',
            textAlign: .center,
          ),
          GoogleSignInButton(onPressed: _busy ? null : _signIn),
          if (_error case final error?)
            Text(
              error,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          Text(
            'Sign-in is necessary so that we can enforce '
            'rate limits to prevent abuse.',
            style: Theme.of(context).mutedBodySmall,
            textAlign: .center,
          ),
        ],
      ),
    ),
  );

  Future<void> _signIn() async {
    setState(() {
      _busy = true;
      _error = null;
    });

    final error = await ServiceLocator.get<AuthManager>().signIn();
    if (!mounted) return;

    setState(() {
      _busy = false;
      _error = error;
    });
  }
}
