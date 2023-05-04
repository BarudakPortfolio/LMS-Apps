import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/materi/data/materi_api.dart';
import 'package:lms/src/features/materi/provider/materi_detail/materi_detail_notifier.dart';
import 'package:lms/src/features/materi/provider/materi_detail/materi_detail_state.dart';

final materiDetailNotifierProvider =
    StateNotifierProvider<MateriDetailNotifier, MateriDetailState>((ref) {
  return MateriDetailNotifier(ref.watch(materiApiProvider));
});
