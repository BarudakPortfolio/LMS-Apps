import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/core/utils/storage.dart';

import 'package:lms/src/features/auth/data/auth_api.dart';
import 'package:lms/src/features/injection/injection_provider.dart';

import 'auth_state.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final getIt = ref.watch(getItProvider);
  return AuthNotifier(
    authApi: getIt<AuthApi>(),
    storage: getIt<SecureStorage>(),
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthApi authApi;
  final SecureStorage storage;

  AuthNotifier({required this.authApi, required this.storage})
      : super(AuthState.unAuthenticated());

  Future login(String username, String password) async {
    final token = await authApi.login(username: username, password: password);
    token.fold((l) {
      state = AuthState.unAuthenticated();
    }, (r) async {
      await storage.write("token", r);
      await storage.write("username", username);
      await storage.write("password", password);
      state = AuthState.authenticated(r);
    });
  }

  Future loginCheck() async {
    String? token = await storage.read('token');
    if (token!.isNotEmpty) {
      state = AuthState.authenticated(token);
    } else {
      state = AuthState.unAuthenticated();
    }
  }
}
