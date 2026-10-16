import 'package:firebase_auth/firebase_auth.dart';

/// The auth manager.
///
/// A wrapper around FirebaseAuth.
class AuthManager {
  /// Closing the popup is a choice, not a failure.
  static const _cancelled = {'popup-closed-by-user', 'cancelled-popup-request'};

  /// The signed-in user's id, `null` when signed out.
  late final Stream<String?> uidChanges = FirebaseAuth.instance
      .authStateChanges()
      .map((user) => user?.uid)
      .distinct()
      .asBroadcastStream();

  /// The signed-in user's id now, `null` when signed out.
  String? get uid => FirebaseAuth.instance.currentUser?.uid;

  /// Authenticates a user using a popup-based authentication flow.
  ///
  /// Returns an error message in case of failure.
  Future<String?> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());

      return null;
    } on FirebaseAuthException catch (error) {
      return _cancelled.contains(error.code)
          ? null
          : error.message ?? 'Sign-in failed.';
    }
  }

  /// Signs the user out.
  Future<void> signOut() => FirebaseAuth.instance.signOut();
}
