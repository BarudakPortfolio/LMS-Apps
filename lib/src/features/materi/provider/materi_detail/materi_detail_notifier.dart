import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/materi/data/materi_api.dart';
import 'package:lms/src/features/storage/service/storage.dart';

import 'materi_detail_state.dart';

class MateriDetailNotifier extends StateNotifier<MateriDetailState> {
  final MateriApi materiApi;
  final SecureStorage storage;
  MateriDetailNotifier({required this.materiApi, required this.storage})
      : super(MateriDetailState.noState());

  Future getMateriDetail(int id) async {
    state = MateriDetailState.loading();
    final token = await storage.read('token');
    final materi = await materiApi.getMateriDetail(id, token);
    materi.fold(
      (l) => state = MateriDetailState.error(l),
      (r) => state = MateriDetailState.finished(r),
    );
  }
}
