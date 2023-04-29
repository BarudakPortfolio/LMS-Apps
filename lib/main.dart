import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:lms/src/core/utils/storage.dart';
import 'package:lms/src/features/auth/data/auth_api.dart';

import 'src/app.dart';

void main() {
  final GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton(() => AuthApi());
  getIt.registerLazySingleton(() => SecureStorage());

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}
