import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/assigment/data/assigment_api.dart';
import 'package:lms/src/features/assigment/provider/assigment/assigment_state.dart';
import 'package:lms/src/features/storage/service/storage.dart';

class AssigmentNotifier extends StateNotifier<AssigmentState> {
  final SecureStorage storage;
  final AssigmentApi assigmentApi;
  AssigmentNotifier({required this.storage, required this.assigmentApi})
      : super(AssigmentState.noState());

  void getAssigment({String? newStatus, String? newMapelId}) async {
    state = AssigmentState.loading();
    final token = await storage.read('token');
    final result = await assigmentApi.getAssigment(
      token,
      status: newStatus,
      mapelId: newMapelId,
    );
    result.fold(
      (l) => state = AssigmentState.error(l),
      (r) => state = AssigmentState.finished(r),
    );
  }
}
