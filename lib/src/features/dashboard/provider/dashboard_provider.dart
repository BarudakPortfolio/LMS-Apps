import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/dashboard_api.dart';
import 'dashboard_notifier.dart';
import 'dashboard_state.dart';

final dashboardNotifierProvider =
    StateNotifierProvider.autoDispose<DashboardNotifier, DashboardState>(
  (ref) {
    return DashboardNotifier(dashboardApi: ref.watch(dashboardApiProvider));
  },
);
