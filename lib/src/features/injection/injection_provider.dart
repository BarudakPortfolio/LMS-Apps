import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:lms/src/features/auth/provider/auth_notifier.dart';

import '../auth/provider/auth_state.dart';

final getItProvider = Provider<GetIt>((ref) {
  GetIt getIt = GetIt.instance;
  return getIt;
});
