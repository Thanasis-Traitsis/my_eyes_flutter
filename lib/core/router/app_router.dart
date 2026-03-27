import 'package:go_router/go_router.dart';
import 'package:my_eyes/core/constants/app_keys.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/app_routes.dart';
import 'package:my_eyes/presentation/shared/screens/screen_with_navbar.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    navigatorKey: AppKeys.rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScreenWithNavbar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: AppPages.home.name,
                builder: (context, state) => AppPages.home.builder(context),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.eyeTest,
                name: AppPages.eyeTest.name,
                builder: (context, state) => AppPages.eyeTest.builder(context),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.eyewear,
                name: AppPages.eyewear.name,
                builder: (context, state) => AppPages.eyewear.builder(context),
                routes: [
                  GoRoute(
                    path: AppPages.eyewearNew.path,
                    name: AppPages.eyewearNew.name,
                    builder: (context, state) =>
                        AppPages.eyewearNew.builder(context),
                  ),
                  GoRoute(
                    path: AppPages.eyewearDetail.path,
                    name: AppPages.eyewearDetail.name,
                    builder: (context, state) =>
                        AppPages.eyewearDetail.builder(context),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: AppPages.profile.name,
                builder: (context, state) => AppPages.profile.builder(context),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        parentNavigatorKey: AppKeys.rootNavigatorKey,
        path: AppRoutes.notifications,
        name: AppPages.notifications.name,
        builder: (context, state) => AppPages.notifications.builder(context),
      ),
      GoRoute(
        parentNavigatorKey: AppKeys.rootNavigatorKey,
        path: AppRoutes.settings,
        name: AppPages.settings.name,
        builder: (context, state) => AppPages.settings.builder(context),
      ),
      GoRoute(
        parentNavigatorKey: AppKeys.rootNavigatorKey,
        path: AppRoutes.lensNew,
        name: AppPages.lensNew.name,
        builder: (context, state) => AppPages.lensNew.builder(context),
      ),
      GoRoute(
        parentNavigatorKey: AppKeys.rootNavigatorKey,
        path: AppRoutes.lensDetail,
        name: AppPages.lensDetail.name,
        builder: (context, state) => AppPages.lensDetail.builder(context),
      ),
      GoRoute(
        parentNavigatorKey: AppKeys.rootNavigatorKey,
        path: AppRoutes.prescriptionNew,
        name: AppPages.prescriptionNew.name,
        builder: (context, state) => AppPages.prescriptionNew.builder(context),
      ),
      GoRoute(
        parentNavigatorKey: AppKeys.rootNavigatorKey,
        path: AppRoutes.prescriptionDetail,
        name: AppPages.prescriptionDetail.name,
        builder: (context, state) =>
            AppPages.prescriptionDetail.builder(context),
      ),
      GoRoute(
        parentNavigatorKey: AppKeys.rootNavigatorKey,
        path: AppRoutes.prescriptionEdit,
        name: AppPages.prescriptionEdit.name,
        builder: (context, state) => AppPages.prescriptionEdit.builder(context),
      ),
      GoRoute(
        parentNavigatorKey: AppKeys.rootNavigatorKey,
        path: AppRoutes.calendarEvents,
        name: AppPages.calendarEvents.name,
        builder: (context, state) => AppPages.calendarEvents.builder(context),
      ),
    ],

    errorBuilder: (context, state) => AppPages.home.builder(context),
  );
}
