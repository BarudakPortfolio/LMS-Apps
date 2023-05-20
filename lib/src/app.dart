import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/views/screens/assignment_detail_screen.dart';
import 'package:lms/src/views/screens/authorization_camera_screen.dart';
import 'package:lms/src/views/screens/materi_detail_screen.dart';

import 'core/routes/app_routes.dart';
import 'core/style/theme.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "LMS koCak",
      theme: lightTheme,
      routeInformationParser: goRouter.goRouter.routeInformationParser,
      routerDelegate: goRouter.goRouter.routerDelegate,
      routeInformationProvider: goRouter.goRouter.routeInformationProvider,
    );
  }
}
