import '../../../models/kelas.dart';

class ClassState {
  bool isLoading;
  List<Kelas>? classes;
  String? message;

  ClassState({required this.isLoading, this.classes, this.message});

  factory ClassState.noState() => ClassState(isLoading: false);

  factory ClassState.loading() => ClassState(isLoading: true);

  factory ClassState.finished(data) =>
      ClassState(isLoading: false, classes: data);

  factory ClassState.error(message) =>
      ClassState(isLoading: false, message: message);
}
