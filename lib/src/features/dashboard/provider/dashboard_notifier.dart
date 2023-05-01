import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'package:lms/src/features/dashboard/data/dashboard_api.dart';
import 'package:lms/src/features/injection/injection_provider.dart';

import 'dashboard_state.dart';

final dashboardNotifierProvider =
    StateNotifierProvider.autoDispose<DashboardNotifier, DashboardState>(
  (ref) {
    final GetIt getIt = ref.watch(getItProvider);
    return DashboardNotifier(dashboardApi: getIt<DashboardApi>());
  },
);

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier({required this.dashboardApi})
      : super(DashboardState.noRequest());

  final DashboardApi dashboardApi;

  getDashboardData() async {
    state = DashboardState.loading();
    final result = await dashboardApi.getDashboardData();

    result.fold((l) {
      state = DashboardState.error(l);
    }, (r) {
      state = DashboardState.finished(r);
    });
  }
}
