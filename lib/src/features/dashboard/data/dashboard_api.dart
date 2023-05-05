import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/constants.dart';
import '../../storage/provider/storage_provider.dart';
import '../../storage/service/storage.dart';
import 'package:http/http.dart' as http;

final dashboardApiProvider = Provider<DashboardApi>((ref) {
  return DashboardApi(ref.watch(storageProvider));
});

class DashboardApi {
  DashboardApi(this.secureStorage);
  final SecureStorage secureStorage;

  Future<Either<String, Map>> getDashboardData() async {
    final token = await secureStorage.read('token');
    Uri url = Uri.parse('$BASE_URL/student_area/dashboard');
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return Right(result);
    } else {
      return const Left("error when get dashboard data");
    }
  }
}
