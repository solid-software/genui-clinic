import 'dart:ui';

import 'package:clinical_brief/auth/widgets/sign_in_card.dart';
import 'package:flutter/material.dart';

/// Blurs the page and blocks it, with the sign-in card on top.
class SignInOverlay extends StatelessWidget {
  static const double _blur = 8;

  /// Constructor.
  const SignInOverlay();

  @override
  Widget build(BuildContext context) => BackdropFilter(
    filter: ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
    child: Stack(
      fit: .expand,
      children: [
        ModalBarrier(
          dismissible: false,
          color: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.2),
        ),
        const Center(child: SignInCard()),
      ],
    ),
  );
}
