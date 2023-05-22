import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/materi/data/materi_api.dart';
import 'package:lms/src/features/materi/provider/materi/materi_state.dart';
import 'package:lms/src/features/storage/provider/storage_provider.dart';

import 'materi_notifier.dart';

final materiNotifierProvider =
    StateNotifierProvider<MateriNotifier, MateriState>(
  (ref) {
    return MateriNotifier(
      materiApi: ref.watch(materiApiProvider),
      storage: ref.watch(storageProvider),
    );
  },
);
