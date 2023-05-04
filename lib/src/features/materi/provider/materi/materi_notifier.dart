import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/materi/data/materi_api.dart';
import 'package:lms/src/features/materi/provider/materi/materi_state.dart';

class MateriNotifier extends StateNotifier<MateriState> {
  final MateriApi materiApi;
  MateriNotifier(this.materiApi) : super(MateriState.noState());

  Future getMateri() async {
    state = MateriState.loading();
    final materi = await materiApi.getMateri();
    materi.fold(
      (l) => state = MateriState.error(l),
      (r) => state = MateriState.finished(r),
    );
  }
}
