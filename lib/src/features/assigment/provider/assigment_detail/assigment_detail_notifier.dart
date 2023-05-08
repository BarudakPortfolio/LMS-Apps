import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/assigment/data/assigment_api.dart';
import 'package:lms/src/features/assigment/provider/assigment_detail/assigment_detail_state.dart';
import 'package:lms/src/features/storage/service/storage.dart';

class AssignmentDetailNotifier extends StateNotifier<AssignmentDetailState> {
  final AssigmentApi assignmentApi;
  final SecureStorage storage;
  AssignmentDetailNotifier({required this.storage, required this.assignmentApi})
      : super(AssignmentDetailState.noState());

  getDetailAssignment(String idTugas) async {
    final token = await storage.read('token');
    state = AssignmentDetailState.loading();
    final result = await assignmentApi.getDetailAssigment(token, idTugas);
    result.fold(
      (l) => state = AssignmentDetailState.error(l),
      (r) => state = AssignmentDetailState.finished(r),
    );
  }
}
