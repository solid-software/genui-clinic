import 'package:clinical_brief/auth/widgets/user_scope.dart';
import 'package:clinical_brief/catalog_browser/pages/catalog_screen.dart';
import 'package:clinical_brief/check_in/pages/patient_list_screen.dart';
import 'package:clinical_brief/common/routes/app_routes.dart';
import 'package:clinical_brief/common/routes/dashboard_link.dart';
import 'package:clinical_brief/dashboard/pages/dashboard_loader.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

/// The app's routes: today's list, one visit's brief and the catalog. Any
/// other link, or an incomplete brief link, opens the list.
abstract final class AppRouter {
  /// The router the app runs on; pushed routes show in the address bar too.
  static final GoRouter config = _create();

  /// Shows routes as paths, `/check_in` rather than `/#/check_in`.
  ///
  /// Call first in `main`: the engine fixes the URL style when it starts,
  /// and a hot reload does not run `main` again.
  static void usePathUrls() => usePathUrlStrategy();

  static GoRouter _create() {
    GoRouter.optionURLReflectsImperativeAPIs = true;

    return .new(
      initialLocation: AppRoutes.checkIn,
      routes: [
        GoRoute(
          path: AppRoutes.checkIn,
          builder: (_, _) => const UserScope(child: PatientListScreen()),
        ),
        GoRoute(
          path: AppRoutes.dashboard,
          redirect: (_, state) => DashboardLink.fromUri(state.uri).isComplete
              ? null
              : AppRoutes.checkIn,
          builder: (_, state) {
            final link = DashboardLink.fromUri(state.uri);

            return UserScope(
              child: DashboardLoader(
                // Keyed by the link, so another link starts a new visit.
                key: ValueKey(link.location),
                link: link,
              ),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.catalog,
          builder: (_, _) => const UserScope(child: CatalogScreen()),
        ),
      ],
      onException: (_, _, router) => router.go(AppRoutes.checkIn),
    );
  }
}
