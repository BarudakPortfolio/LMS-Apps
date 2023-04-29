import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/core/routes/app_routes.dart';
import 'package:lms/src/views/screens/splash_screen.dart';

import 'src/app.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LMS koCak",
      routes: AppRoutes.routes,
      home: SplashScreen(),
    );
  }
}
