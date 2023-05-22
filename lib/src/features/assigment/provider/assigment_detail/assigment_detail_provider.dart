import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/assigment/provider/assigment_detail/assigment_detail_notifier.dart';
import 'package:lms/src/features/assigment/provider/assigment_detail/assigment_detail_state.dart';
import 'package:lms/src/features/storage/provider/storage_provider.dart';

import '../../data/assigment_api.dart';

final detailAssignmentNotifierProvider =
    StateNotifierProvider<AssignmentDetailNotifier, AssignmentDetailState>(
        (ref) {
  return AssignmentDetailNotifier(
    storage: ref.watch(storageProvider),
    assignmentApi: ref.watch(assigmentProvider),
  );
});
