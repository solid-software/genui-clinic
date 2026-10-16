import 'package:clinical_brief/auth/services/auth_manager.dart';
import 'package:clinical_brief/auth/widgets/sign_in_overlay.dart';
import 'package:clinical_brief/common/di/service_locator.dart';
import 'package:flutter/material.dart';

/// Builds [child] afresh whenever the signed-in user changes, so nothing one
/// user loaded outlives their session and a new session loads from scratch.
///
/// Signed out, [child] shows blurred behind a sign-in card, unreachable by
/// pointer, keyboard and screen reader.
///
/// Wraps each page rather than the whole app: the router's navigator has a
/// global key, which keeps its pages' state across a re-key above it.
class const UserScope({
  super.key,

  /// The page to rebuild for each user.
  required final Widget child,
}) extends StatelessWidget {
  /// Creates a scope around [child].
  this;

  @override
  Widget build(BuildContext context) {
    final auth = ServiceLocator.get<AuthManager>();

    return StreamBuilder(
      stream: auth.uidChanges,
      initialData: auth.uid,
      builder: (_, snapshot) {
        final uid = snapshot.data;
        final signedOut = uid == null;

        return Stack(
          fit: .expand,
          children: [
            ExcludeSemantics(
              excluding: signedOut,
              child: ExcludeFocus(
                excluding: signedOut,
                child: KeyedSubtree(key: ValueKey(uid), child: child),
              ),
            ),
            if (signedOut) const SignInOverlay(),
          ],
        );
      },
    );
  }
}
