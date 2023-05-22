import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:lms/src/models/user.dart';

import '../../../core/common/constants.dart';
import '../../http/provider/http_provider.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.watch(httpProvider));
});

class AuthApi {
  final IOClient client;

  AuthApi(this.client);
  Future<Either<String, String>> login(
      {required String username, required String password}) async {
    Uri url = Uri.parse('$BASE_URL/auth/login');
    Map body = {
      'username': username,
      'password': password,
    };
    final response = await client.post(
      url,
      body: body,
    );
    print(response.body);
    Map<String, dynamic> result = jsonDecode(response.body);
    final isUser = (result['status']) == 1;
    if (isUser) {
      final result = json.decode(response.body);
      print("Berahasil");
      return Right(result['token']);
    } else {
      return const Left('Login gagal');
    }
  }
}
