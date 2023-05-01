import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../core/utils/storage.dart';
import '../auth/data/auth_api.dart';
import '../dashboard/data/dashboard_api.dart';

final getItProvider = Provider<GetIt>((ref) {
  GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton(() => DashboardApi(getIt<SecureStorage>()));
  getIt.registerLazySingleton(() => AuthApi());
  getIt.registerLazySingleton(() => SecureStorage());
  return getIt;
});
