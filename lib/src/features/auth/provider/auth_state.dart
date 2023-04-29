class AuthState {
  final bool isAuthenticated;
  final String? token;
  final String? error;

  AuthState({
    required this.isAuthenticated,
    this.token,
    this.error,
  });

  factory AuthState.authenticated(String token) {
    return AuthState(isAuthenticated: true, token: token);
  }

  factory AuthState.unAuthenticated() {
    return AuthState(isAuthenticated: false, token: null);
  }
}
