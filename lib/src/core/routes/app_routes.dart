import 'package:flutter/material.dart';
import 'package:lms/src/views/screens/login_screen.dart';
import 'package:lms/src/views/screens/main_screen.dart';
import 'package:lms/src/views/screens/splash_screen.dart';

import '../../views/screens/authorization_camera_screen.dart';

class AppRoutes {
  static const splash = '/splashscreen';
  static const login = '/login';
  static const main = '/main';
  static const detailTugas = '/detail-tugas';
  static const detailMateri = '/detail-materi';
  static const cameraAutorisasi = '/authorization';

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    main: (context) => const MainScreen(),
    cameraAutorisasi: (context) => const AuthorizationCameraScreen(),
  };
}
