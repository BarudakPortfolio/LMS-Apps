import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/kelas/provider/class_state.dart';

class ClassNotifier extends StateNotifier<ClassState> {
  ClassNotifier() : super(ClassState.noState());

  Future getAllClass() async {}
}
