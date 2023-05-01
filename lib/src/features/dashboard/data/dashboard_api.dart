import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../core/common/constants.dart';
import '../../../core/utils/storage.dart';
import 'package:http/http.dart' as http;

class DashboardApi {
  DashboardApi(this.secureStorage);
  final SecureStorage secureStorage;

  Future<Either<String, Map>> getDashboardData() async {
    final token = await secureStorage.read('token');
    Uri url = Uri.parse('$baseUrl/student_area/dashboard');
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print(result);
      return Right(result);
    } else {
      return const Left("error when get dashboard data");
    }
  }
}
