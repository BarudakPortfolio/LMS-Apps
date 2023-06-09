import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/materi/data/materi_api.dart';
import 'package:lms/src/features/materi/provider/materi_detail/materi_detail_notifier.dart';
import 'package:lms/src/features/materi/provider/materi_detail/materi_detail_state.dart';
import 'package:lms/src/features/storage/provider/storage_provider.dart';

final materiDetailNotifierProvider =
    StateNotifierProvider<MateriDetailNotifier, MateriDetailState>((ref) {
  return MateriDetailNotifier(
    materiApi: ref.watch(materiApiProvider),
    storage: ref.watch(storageProvider),
  );
});
