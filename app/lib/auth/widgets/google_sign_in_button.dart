import 'package:flutter/material.dart';

/// The "Sign in with Google" button, implemented per guidelines:
/// https://developers.google.com/identity/branding-guidelines
class const GoogleSignInButton({
  super.key,
  required final VoidCallback? onPressed,
}) extends StatelessWidget {
  static const _artwork = 'assets/images/google_sign_in.png'; // Preapproved.
  static const _height = 40.0;

  /// Creates the button.
  this;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: onPressed != null,
    label: 'Sign in with Google',
    excludeSemantics: true,
    child: Opacity(
      opacity: onPressed == null ? 0.38 : 1,
      child: Stack(
        children: [
          Image.asset(_artwork, height: _height),
          Positioned.fill(
            child: Material(
              type: .transparency,
              child: InkWell(
                onTap: onPressed,
                customBorder: const StadiumBorder(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
