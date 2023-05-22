import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/user/provider/user_notifier.dart';
import 'package:lms/src/features/user/provider/user_state.dart';

import '../../storage/provider/storage_provider.dart';
import '../data/user_api.dart';

final userNotifierProvider =
    StateNotifierProvider.autoDispose<UserNotifier, UserState>((ref) {
  return UserNotifier(
      userApi: ref.watch(userApiProvider), storage: ref.watch(storageProvider));
});
