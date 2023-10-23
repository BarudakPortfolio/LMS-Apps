import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class States<T> with _$States<T> {
  const factory States({
    @Default(false) isLoading,
    @Default(false) isLoadingMore,
    String? error,
    T? data,
    @Default(1) int page,
    @Default(1) int lastPage,
    @Default(0) int total,
  }) = _States;
}

class State<T> {
  final T? data;
  final String? error;
  final bool isLoading;

  State({this.data, required this.isLoading, this.error});

  factory State.finished(T? data) {
    return State(data: data, isLoading: false);
  }

  factory State.noState() {
    return State(isLoading: false);
  }

  factory State.loading() {
    return State(isLoading: true);
  }
  factory State.error(String error) {
    return State(isLoading: false, error: error);
  }
}