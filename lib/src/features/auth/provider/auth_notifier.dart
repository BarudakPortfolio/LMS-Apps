import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/storage/service/storage.dart';

import 'package:lms/src/features/auth/data/auth_api.dart';

import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthApi authApi;
  final SecureStorage storage;

  AuthNotifier({required this.authApi, required this.storage})
      : super(AuthState.unAuthenticated());

  Future<bool> login(String username, String password) async {
    state = AuthState.loading();
    final token = await authApi.login(username: username, password: password);
    return token.fold((l) {
      state = AuthState.unAuthenticated();
      return false;
    }, (r) async {
      await storage.write("token", r);
      await storage.write("username", username);
      await storage.write("password", password);

      state = AuthState.authenticated(r);
      return true;
    });
  }

  logout() async {
    await storage.deleteAll();
    state = AuthState.unAuthenticated();
  }
}
