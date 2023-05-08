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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LMS koCak",
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splash,
      theme: lightTheme,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.detailMateri:
            return MaterialPageRoute(builder: (context) {
              final id = settings.arguments as int;
              return MateriDetailScreen(id: id);
            });
          case AppRoutes.cameraAutorisasi:
            return MaterialPageRoute(builder: (context) {
              final id = settings.arguments as String;
              return AuthorizationCameraScreen(id);
            });
          case AppRoutes.detailTugas:
            return MaterialPageRoute(builder: (context) {
              final id = settings.arguments as String;
              return AssignmentDetailScreen(id);
            });
          default:
        }
      },
    );
  }
}
