import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/kelas/provider/class_state.dart';
import 'package:lms/src/features/storage/provider/storage_provider.dart';

import '../../storage/service/storage.dart';
import '../data/class_api.dart';

final classNotifierProvider =
    StateNotifierProvider<ClassNotifier, ClassState>((ref) {
  return ClassNotifier(
      storage: ref.watch(storageProvider),
      classApi: ref.watch(classApiProvider));
});

class ClassNotifier extends StateNotifier<ClassState> {
  ClassNotifier({required this.storage, required this.classApi})
      : super(ClassState.noState());

  final ClassApi classApi;
  final SecureStorage storage;

  getAllClass() async {
    state = ClassState.loading();
    final token = await storage.read('token');
    final result = await classApi.getAllClass(token);

    result.fold(
      (l) => state = ClassState.error(l),
      (r) => state = ClassState.finished(r),
    );
  }
}
