import '../../../models/materi.dart';

class MateriState {
  bool isLoading;
  List<Materi>? data;
  String? error;

  MateriState({required this.isLoading, this.data, this.error});

  factory MateriState.finished(List<Materi> listMateri) =>
      MateriState(isLoading: false, data: listMateri);

  factory MateriState.noState() => MateriState(isLoading: false);

  factory MateriState.error(String message) =>
      MateriState(isLoading: false, error: message);

  factory MateriState.loading() => MateriState(isLoading: true);
}
