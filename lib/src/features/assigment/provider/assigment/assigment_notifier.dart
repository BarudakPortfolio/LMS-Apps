import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/assigment/data/assigment_api.dart';
import 'package:lms/src/features/state.dart';
import 'package:lms/src/features/storage/service/storage.dart';
import 'package:lms/src/models/tugas.dart';

import '../../../../core/utils/helper/exception_to_message.dart';

class AssigmentNotifier extends StateNotifier<State<List<Tugas>>> {
  final AssigmentApi assigmentApi;

  AssigmentNotifier(this.assigmentApi) : super(State.noState());

  void getAssigment({String? newStatus, String? newMapelId}) async {
    state = State.loading();
    try {
      final result = await assigmentApi.getAssigment(
        status: newStatus,
        mapelId: newMapelId,
      );
      result.fold(
        (error) => state = State.error(error),
        (data) => state = State.finished(data),
      );
    } catch (exception) {
      state = State.error(exceptionTomessage(exception));
    }
  }
}

class ArchiveAssigmentNotifier
    extends StateNotifier<List<Map<String, dynamic>>> {
  final AssigmentApi assigmentApi;
  final SecureStorage storage;

  ArchiveAssigmentNotifier({
    required this.assigmentApi,
    required this.storage,
  }) : super([]);

  Future addArchiveAssigment() async {
    Map<String, dynamic> archiveResult =
        await assigmentApi.addArchiveAssignment();
    state = [...state, archiveResult];
  }

  removeArchiveAssigment(String idFile) {
    state = state.where((element) => element['id'] != idFile).toList();
  }

  clearArchiveAssignment() {
    state = [];
  }

  Future sendAssignment(
    String idAssignment,
    String newLinkDownload,
    String newLinkYoutube,
  ) async {
    final token = await storage.read('token');
    await assigmentApi.sendAssignment(
      token,
      id: idAssignment,
      linkDownload: newLinkDownload,
      linkYoutube: newLinkYoutube,
    );
    for (var element in state) {
      await assigmentApi.sendFile(idAssignment, path: element['path']);
    }
  }
}
