import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../storage/provider/storage_provider.dart';
import '../data/auth_api.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    authApi: ref.watch(authApiProvider),
    storage: ref.watch(storageProvider),
  ),
);
