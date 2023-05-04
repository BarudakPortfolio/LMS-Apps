import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/materi/data/materi_api.dart';
import 'package:lms/src/features/materi/provider/materi_notifier.dart';
import 'package:lms/src/features/materi/provider/materi_state.dart';

final materiNotifierProvider =
    StateNotifierProvider<MateriNotifier, MateriState>((ref) {
  return MateriNotifier(ref.watch(materiApiProvider));
});
