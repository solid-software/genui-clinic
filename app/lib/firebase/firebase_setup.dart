import 'package:clinical_brief/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Connects the app to Firebase and attests it with App Check.
abstract final class FirebaseSetup {
  /// reCAPTCHA Enterprise key for web release builds; CI passes it in.
  static const String _recaptchaSiteKey = String.fromEnvironment(
    'RECAPTCHA_SITE_KEY',
  );

  /// The team's App Check debug token for local runs; see app/README.md.
  static const String _appCheckDebugToken = String.fromEnvironment(
    'APP_CHECK_DEBUG_TOKEN',
  );

  /// Initializes Firebase, then App Check. Call once, before any brief
  /// request.
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await _activateAppCheck();
  }

  /// Attests the app to Firebase; the brief agent rejects calls without it.
  static Future<void> _activateAppCheck() {
    // Without a token, debug providers print a new one to register.
    final String? debugToken = _appCheckDebugToken.isEmpty
        ? null
        : _appCheckDebugToken;

    return FirebaseAppCheck.instance.activate(
      providerAndroid: kDebugMode
          ? AndroidDebugProvider(debugToken: debugToken)
          : const AndroidPlayIntegrityProvider(),
      providerApple: kDebugMode
          ? AppleDebugProvider(debugToken: debugToken)
          : const AppleAppAttestProvider(),
      providerWeb: kDebugMode
          ? WebDebugProvider(debugToken: debugToken)
          : ReCaptchaEnterpriseProvider(_recaptchaSiteKey),
    );
  }
}
