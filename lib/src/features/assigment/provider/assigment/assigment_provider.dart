import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/assigment/data/assigment_api.dart';
import 'package:lms/src/features/assigment/provider/assigment/assigment_notifier.dart';
import 'package:lms/src/features/state.dart';
import 'package:lms/src/features/storage/provider/storage_provider.dart';
import 'package:lms/src/models/tugas.dart';

//State Provider

final assigmentNotifierProvider =
    StateNotifierProvider<AssigmentNotifier, State<List<Tugas>>>((ref) {
  return AssigmentNotifier(ref.watch(assigmentProvider));
});

final archiveAssigmentNotifier =
    StateNotifierProvider<ArchiveAssigmentNotifier, List<Map<String, dynamic>>>(
        (ref) {
  return ArchiveAssigmentNotifier(
    storage: ref.watch(storageProvider),
    assigmentApi: ref.watch(assigmentProvider),
  );
});
