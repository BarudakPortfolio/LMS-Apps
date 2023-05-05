import '../../../../models/tugas.dart';

class AssigmentState {
  bool isLoading;
  List<Tugas>? data;
  String? error;

  AssigmentState({required this.isLoading, this.data, this.error});

  factory AssigmentState.finished(List<Tugas> listTugas) =>
      AssigmentState(isLoading: false, data: listTugas);

  factory AssigmentState.noState() => AssigmentState(isLoading: false);

  factory AssigmentState.error(String message) =>
      AssigmentState(isLoading: false, error: message);

  factory AssigmentState.loading() => AssigmentState(isLoading: true);
}
