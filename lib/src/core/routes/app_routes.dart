import 'package:flutter/material.dart';
import 'package:lms/src/views/screens/login_screen.dart';

class AppRoutes {
  static const splash = '/splashscreen';
  static const login = '/login';
  static const main = '/main';
  static const home = '/home';
  static const tugas = '/tugas';
  static const materi = '/materi';
  static const kelas = '/kelas';
  static const profile = '/profile';
  static const detailTugas = '/detail-tugas';
  static const detailMateri = '/detail-materi';

  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.login: (context) => const LoginScreen(),
  };
}
