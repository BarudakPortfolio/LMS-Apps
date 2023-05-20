import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/src/views/screens/assignment_detail_screen.dart';
import 'package:lms/src/views/screens/login_screen.dart';
import 'package:lms/src/views/screens/main_screen.dart';
import 'package:lms/src/views/screens/materi_detail_screen.dart';
import 'package:lms/src/views/screens/splash_screen.dart';

import '../../features/storage/provider/storage_provider.dart';
import '../../views/screens/authorization_camera_screen.dart';

final goRouterProvider = Provider<AppRoutes>((ref) {
  return AppRoutes(ref);
});

final loginCheckProvider = Provider<bool>((ref) {
  final storage = ref.watch(storageProvider);
  bool isLoggedIn = false;
  storage.read('token').then((value) {
    if (value != null) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
  });
  return isLoggedIn;
});

class AppRoutes {
  ProviderRef ref;
  AppRoutes(this.ref);

  static const String splash = '/';
  static const String main = 'main';
  static const String login = 'login';
  static const String materiDetail = 'materi-detail';
  static const String assignmentDetail = 'assignment-detail';
  static const String cameraAuth = 'camera-auth';
  static Page _splashPageBuilder(BuildContext context, GoRouterState state) {
    return const MaterialPage(child: SplashScreen());
  }

  static Page _mainPageBuilder(BuildContext context, GoRouterState state) {
    return const MaterialPage(child: MainScreen());
  }

  static Page _loginPageBuilder(BuildContext context, GoRouterState state) {
    return const MaterialPage(child: LoginScreen());
  }

  static Page _materiDetailPageBuilder(
      BuildContext context, GoRouterState state) {
    String id = state.pathParameters['id'] ?? '0';
    return MaterialPage(
        child: MateriDetailScreen(
      id: int.parse(id),
    ));
  }

  static Page _assignmentDetailPageBuilder(
      BuildContext context, GoRouterState state) {
    String id = state.pathParameters['id'] ?? '0';
    return MaterialPage(child: AssignmentDetailScreen(id));
  }

  static Page _authorizationCameraPageBuilder(
      BuildContext context, GoRouterState state) {
    String id = state.pathParameters['id'] ?? '0';
    final isAssignment = state.pathParameters['is-assignment'];
    return MaterialPage(
      child: AuthorizationCameraScreen(
        id,
        isTugas: isAssignment!.toLowerCase() == 'true',
      ),
    );
  }

  final GoRouter _goRouter = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    routerNeglect: true,
    routes: [
      GoRoute(
        path: splash,
        pageBuilder: _splashPageBuilder,
        name: splash,
        routes: [
          GoRoute(
            path: login,
            name: login,
            pageBuilder: _loginPageBuilder,
          ),
          GoRoute(
            name: main,
            path: main,
            pageBuilder: _mainPageBuilder,
            routes: [
              GoRoute(
                name: materiDetail,
                path: '$materiDetail:id',
                pageBuilder: _materiDetailPageBuilder,
              ),
              GoRoute(
                  name: assignmentDetail,
                  path: '$assignmentDetail:id',
                  pageBuilder: _assignmentDetailPageBuilder,
                  routes: [
                    GoRoute(
                      path: cameraAuth,
                      name: cameraAuth,
                      pageBuilder: _authorizationCameraPageBuilder,
                    )
                  ]),
            ],
          ),
        ],
      ),
    ],
  );

  GoRouter get goRouter => _goRouter;
}
