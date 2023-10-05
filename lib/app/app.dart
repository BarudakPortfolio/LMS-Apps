import 'package:flutter/material.dart';

import '../router/router.import.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "ELearning ITG",
      routerConfig: AppRoutes.router,
    );
  }
}
