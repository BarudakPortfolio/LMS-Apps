import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lms/src/features/dashboard/data/dashboard_api.dart';

import '../../storage/service/storage.dart';
import 'dashboard_state.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier({required this.dashboardApi, required this.storage})
      : super(DashboardState.noRequest());

  final DashboardApi dashboardApi;
  final SecureStorage storage;

  getDashboardData() async {
    state = DashboardState.loading();
    final token = await storage.read('token');
    final result = await dashboardApi.getDashboardData(token);

    result.fold((l) => state = DashboardState.error(l),
        (r) => state = DashboardState.finished(r));
  }
}
