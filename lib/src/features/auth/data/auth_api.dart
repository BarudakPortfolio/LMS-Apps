import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../core/common/constants.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi();
});

class AuthApi {
  Future<Either<String, String>> login(
      {required String username, required String password}) async {
    Uri url = Uri.parse('$baseUrl/auth/login');
    Map body = {
      'username': username,
      'password': password,
    };
    final response = await http.post(
      url,
      body: body,
    );

    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      return Right(result['token']);
    } else {
      return const Left('Login gagal');
    }
  }
}
