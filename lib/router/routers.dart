part of "router.import.dart";

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: "/splash",
    routes: [
      GoRoute(
        path: "/splash",
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: "/login",
        builder: (_, __) => const LoginScreen(),
      ),
    ],
  );
}
