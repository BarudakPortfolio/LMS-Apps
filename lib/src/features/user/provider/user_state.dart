import '../../../models/user.dart';

class UserState {
  final UserModel? user;
  final bool isLoading;
  final String? message;

  UserState({this.user, required this.isLoading, this.message});

  factory UserState.noState() => UserState(isLoading: false);
  factory UserState.loading() => UserState(isLoading: true);
  factory UserState.error(message) =>
      UserState(isLoading: false, message: message);

  factory UserState.finished(data) => UserState(isLoading: false, user: data);
}
