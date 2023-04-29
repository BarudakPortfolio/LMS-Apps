import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lms/src/features/auth/data/auth_api.dart';

import 'auth_state.dart';

class AuthNotifier extends StateNotifier {
  final AuthApi _authApi;

  AuthNotifier(this._authApi) : super(AuthState.unAuthenticated());

  Future login(String username, String password) async {
    final token = await _authApi.login(username: username, password: password);
    token.fold((l) {
      state = AuthState.unAuthenticated();
    }, (r) {
      state = AuthState.authenticated(r);
    });
  }
}
