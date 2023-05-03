import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lms/src/features/dashboard/data/dashboard_api.dart';

import 'dashboard_state.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier({required this.dashboardApi})
      : super(DashboardState.noRequest());

  final DashboardApi dashboardApi;

  getDashboardData() async {
    state = DashboardState.loading();
    final result = await dashboardApi.getDashboardData();

    result.fold((l) => state = DashboardState.error(l),
        (r) => state = DashboardState.finished(r));
  }
}
