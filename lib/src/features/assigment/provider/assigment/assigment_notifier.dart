import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/assigment/data/assigment_api.dart';
import 'package:lms/src/features/assigment/provider/assigment/assigment_state.dart';
import 'package:lms/src/features/storage/service/storage.dart';

class AssigmentNotifier extends StateNotifier<AssigmentState> {
  final SecureStorage storage;
  final AssigmentApi assigmentApi;
  AssigmentNotifier({required this.storage, required this.assigmentApi})
      : super(AssigmentState.noState());

  void getAssigment({String? newStatus, String? newMapelId}) async {
    state = AssigmentState.loading();
    final token = await storage.read('token');
    final result = await assigmentApi.getAssigment(
      token,
      status: newStatus,
      mapelId: newMapelId,
    );
    result.fold(
      (l) => state = AssigmentState.error(l),
      (r) => state = AssigmentState.finished(r),
    );
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
