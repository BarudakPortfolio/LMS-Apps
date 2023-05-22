import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final autorisasiNotifierProvider =
    StateNotifierProvider<AutorisasiNotifier, File>((ref) {
  return AutorisasiNotifier();
});

class AutorisasiNotifier extends StateNotifier<File> {
  AutorisasiNotifier() : super(File(''));

  void saveReviewAutorisasi(File newFile) => state = newFile;
}
