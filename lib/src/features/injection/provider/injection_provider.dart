import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

import '../../storage/service/storage.dart';
import '../../auth/data/auth_api.dart';
import '../../dashboard/data/dashboard_api.dart';

final getItProvider = Provider<GetIt>((ref) {
  GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton(
    () => DashboardApi(
      client: getIt<IOClient>(),
    ),
  );
  getIt.registerLazySingleton(() => AuthApi(getIt<IOClient>()));
  getIt.registerLazySingleton(() => SecureStorage());
  getIt.registerLazySingleton(() => IOClient());
  return getIt;
});
