import 'package:lms/src/models/tugas.dart';

class AssignmentDetailState {
  bool isLoading;
  String? error;
  Tugas? data;

  AssignmentDetailState({required this.isLoading, this.error, this.data});

  factory AssignmentDetailState.finished(Tugas tugas) =>
      AssignmentDetailState(isLoading: false, data: tugas);

  factory AssignmentDetailState.noState() =>
      AssignmentDetailState(isLoading: false);

  factory AssignmentDetailState.error(String message) =>
      AssignmentDetailState(isLoading: false, error: message);

  factory AssignmentDetailState.loading() =>
      AssignmentDetailState(isLoading: true);
}
