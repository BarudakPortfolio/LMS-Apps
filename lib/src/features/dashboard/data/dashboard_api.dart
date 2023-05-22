import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';

import '../../../core/common/constants.dart';
import '../../http/provider/http_provider.dart';
import '../../storage/provider/storage_provider.dart';
import '../../storage/service/storage.dart';

final dashboardApiProvider = Provider<DashboardApi>((ref) {
  return DashboardApi(client: ref.watch(httpProvider));
});

class DashboardApi {
  DashboardApi({required this.client});

  final IOClient client;

  Future<Either<String, Map>> getDashboardData(String token) async {
    Uri url = Uri.parse('$BASE_URL/student_area/dashboard');
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return Right(result);
    } else {
      return const Left("error when get dashboard data");
    }
  }
}
