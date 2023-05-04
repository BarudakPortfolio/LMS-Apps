import '../../../../models/materi.dart';

class MateriDetailState {
  bool isLoading;
  String? error;
  Materi? data;

  MateriDetailState({required this.isLoading, this.error, this.data});

  factory MateriDetailState.finished(Materi materi) =>
      MateriDetailState(isLoading: false, data: materi);

  factory MateriDetailState.noState() => MateriDetailState(isLoading: false);

  factory MateriDetailState.error(String message) =>
      MateriDetailState(isLoading: false, error: message);

  factory MateriDetailState.loading() => MateriDetailState(isLoading: true);
}
