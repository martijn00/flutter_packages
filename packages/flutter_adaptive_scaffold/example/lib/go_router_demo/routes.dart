import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'global_router.dart' as router show rootNavigatorKey;

import 'global_router.dart';
import 'pages/pages.dart';
import 'scaffold_shell.dart';

final GlobalKey<NavigatorState> _homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _counterNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'counter');
final GlobalKey<NavigatorState> _moreNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'more');

/// Stores the routes that are accessible to unauthenticated users.
class Routes {
  /// The route for the login page.
  static final GoRoute unauthenticatedRoutes = GoRoute(
    name: LoginPage.name,
    path: LoginPage.path,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return const MaterialPage<void>(child: LoginPage());
    },
    redirect: (BuildContext context, GoRouterState state) {
      if (GlobalRouter.authenticated) {
        return HomePage.path;
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        name: ForgotPasswordPage.name,
        path: ForgotPasswordPage.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage<void>(
            child: ForgotPasswordPage(),
          );
        },
      ),
    ],
  );

  /// The routes for the authenticated user.
  static final StatefulShellRoute authenticatedRoutes =
      StatefulShellRoute.indexedStack(
    parentNavigatorKey: router.rootNavigatorKey,
    builder: (
      BuildContext context,
      GoRouterState state,
      StatefulNavigationShell navigationShell,
    ) {
      return ScaffoldShell(navigationShell: navigationShell);
    },
    redirect: (BuildContext context, GoRouterState state) {
      if (!GlobalRouter.authenticated) {
        return LoginPage.path;
      }
      return null;
    },
    branches: <StatefulShellBranch>[
      StatefulShellBranch(
        navigatorKey: _homeNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            name: HomePage.name,
            path: HomePage.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              //Maybe NoTransitionPage?
              return const MaterialPage<void>(
                child: HomePage(),
              );
            },
            routes: <RouteBase>[
              GoRoute(
                name: DetailPage.name,
                path: DetailPage.path,
                parentNavigatorKey: router.rootNavigatorKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const MaterialPage<void>(
                    child: DetailPage(),
                  );
                },
              ),
              GoRoute(
                name: DetailModalPage.name,
                path: DetailModalPage.path,
                parentNavigatorKey: router.rootNavigatorKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const MaterialPage<void>(
                    fullscreenDialog: true,
                    child: DetailModalPage(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _counterNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            name: CounterPage.name,
            path: CounterPage.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const MaterialPage<void>(child: CounterPage());
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _moreNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            name: MorePage.name,
            path: MorePage.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const MaterialPage<void>(
                key: ValueKey<String>(MorePage.name),
                child: MorePage(),
              );
            },
            routes: <RouteBase>[
              GoRoute(
                path: ProfilePage.path,
                name: ProfilePage.name,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const MaterialPage<void>(child: ProfilePage());
                },
              ),
              GoRoute(
                name: SettingsPage.name,
                path: SettingsPage.path,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const MaterialPage<void>(child: SettingsPage());
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static final List<GoRoute> commonRoutes = <GoRoute>[
    GoRoute(
      name: LanguagePage.name,
      path: LanguagePage.path,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const MaterialPage<void>(
          child: LanguagePage(),
        );
      },
    ),
  ];
}
