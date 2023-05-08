import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/user/provider/user_state.dart';
import 'package:lms/src/models/user.dart';

import '../../storage/service/storage.dart';
import '../data/user_api.dart';

class UserNotifier extends StateNotifier<UserState> {
  final UserApi userApi;
  final SecureStorage storage;

  UserNotifier({required this.userApi, required this.storage})
      : super(UserState.noState());

  Future getUser() async {
    UserModel? user;
    state = UserState.loading();
    final result = await userApi.getUser();

    result.fold((l) => state = UserState.error(l), (r) {
      user = UserModel.fromJson(r);
      state = UserState.finished(UserModel.fromJson(r));
    });
    return user;
  }
}
