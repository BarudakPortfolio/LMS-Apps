class DashboardState {
  Map? data;
  String? message;
  bool isLoading;

  DashboardState({this.data, this.message, required this.isLoading});

  factory DashboardState.noRequest() => DashboardState(isLoading: false);
  factory DashboardState.loading() => DashboardState(isLoading: true);

  factory DashboardState.error(message) =>
      DashboardState(isLoading: false, message: 'Gagal mendapatkan data');

  factory DashboardState.finished(data) =>
      DashboardState(isLoading: false, data: data['data']);
}
