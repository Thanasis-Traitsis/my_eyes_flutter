import 'package:go_router/go_router.dart';
import 'package:my_eyes/core/constants/app_keys.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/app_routes.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/presentation/eyewear/screens/add_eyewear_screen.dart';
import 'package:my_eyes/presentation/shared/screens/screen_with_navbar.dart';
import 'package:my_eyes/presentation/test_history/screens/test_history_screen.dart';

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
        path: AppRoutes.editProfile,
        name: AppPages.editProfile.name,
        builder: (context, state) => AppPages.editProfile.builder(context),
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
        path: AppRoutes.eyewearNew,
        name: AppPages.eyewearNew.name,
        builder: (context, state) =>
            AddEyewearScreen(category: state.extra as EyewearCategory?),
      ),
      GoRoute(
        parentNavigatorKey: AppKeys.rootNavigatorKey,
        path: AppRoutes.eyewearEdit,
        name: AppPages.eyewearEdit.name,
        builder: (context, state) =>
            AddEyewearScreen(eyewearItem: state.extra as EyewearItem?),
      ),
      GoRoute(
        parentNavigatorKey: AppKeys.rootNavigatorKey,
        path: AppRoutes.testHistory,
        name: AppPages.testHistory.name,
        builder: (context, state) =>
            TestHistoryScreen(args: state.extra as TestHistoryScreenArgs?),
      ),
      GoRoute(
        parentNavigatorKey: AppKeys.rootNavigatorKey,
        path: AppRoutes.newEyeTest,
        name: AppPages.newEyeTest.name,
        builder: (context, state) => AppPages.newEyeTest.builder(context),
      ),
      // ============================
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
