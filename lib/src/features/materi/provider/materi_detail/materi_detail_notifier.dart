import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/materi/data/materi_api.dart';

import 'materi_detail_state.dart';

class MateriDetailNotifier extends StateNotifier<MateriDetailState> {
  final MateriApi materiApi;
  MateriDetailNotifier(this.materiApi) : super(MateriDetailState.noState());

  Future getMateriDetail(int id) async {
    state = MateriDetailState.loading();
    final materi = await materiApi.getMateriDetail(id);
    materi.fold(
      (l) => state = MateriDetailState.error(l),
      (r) => state = MateriDetailState.finished(r),
    );
  }
}
