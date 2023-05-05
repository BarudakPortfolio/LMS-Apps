import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import '../../../core/common/constants.dart';
import '../../http/provider/http_provider.dart';
import '../../storage/provider/storage_provider.dart';
import '../../storage/service/storage.dart';

final userApiProvider = Provider<UserApi>((ref) {
  return UserApi(ref.watch(httpProvider), ref.watch(storageProvider));
});

class UserApi {
  final IOClient client;
  final SecureStorage storage;

  UserApi(this.client, this.storage);
  Future<Either<String, Map>> getUser() async {
    final token = await storage.read('token');
    Uri url = Uri.parse('$BASE_URL/student_area/profile');
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return Right(result['data']);
    } else {
      return const Left('Gagal mendapatkan data');
    }
  }
}
