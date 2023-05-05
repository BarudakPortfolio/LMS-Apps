import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/materi/data/materi_api.dart';
import 'package:lms/src/features/materi/provider/materi/materi_state.dart';
import 'package:lms/src/features/storage/service/storage.dart';

class MateriNotifier extends StateNotifier<MateriState> {
  final MateriApi materiApi;
  final SecureStorage storage;
  MateriNotifier({required this.materiApi, required this.storage})
      : super(MateriState.noState());

  Future getMateri() async {
    state = MateriState.loading();
    final token = await storage.read('token');
    final materi = await materiApi.getMateri(token);
    materi.fold(
      (l) => state = MateriState.error(l),
      (r) => state = MateriState.finished(r),
    );
  }
}
