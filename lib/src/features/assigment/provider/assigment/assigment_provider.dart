import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/assigment/data/assigment_api.dart';
import 'package:lms/src/features/assigment/provider/assigment/assigment_notifier.dart';
import 'package:lms/src/features/assigment/provider/assigment/assigment_state.dart';
import 'package:lms/src/features/storage/provider/storage_provider.dart';

final assigmentNotifierProvider =
    StateNotifierProvider<AssigmentNotifier, AssigmentState>((ref) {
  return AssigmentNotifier(
      storage: ref.watch(storageProvider),
      assigmentApi: ref.watch(assigmentProvider));
});

final archiveAssigmentNotifier =
    StateNotifierProvider<ArchiveAssigmentNotifier, List<Map<String, dynamic>>>(
        (ref) {
  return ArchiveAssigmentNotifier(
    storage: ref.watch(storageProvider),
    assigmentApi: ref.watch(assigmentProvider),
  );
});
