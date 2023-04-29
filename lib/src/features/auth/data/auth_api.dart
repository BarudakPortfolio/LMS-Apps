import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi();
});

class AuthApi {
  static const _baseUrl = 'https://elearning.itg.ac.id/api';
  Future<Either<String, String>> login(
      {required String username, required String password}) async {
    Uri url = Uri.parse('$_baseUrl/auth/login');
    Map body = {
      'username': username,
      'password': password,
    };
    final response = await http.post(
      url,
      body: body,
    );
    print(response.body);

    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      return Right(result['token']);
    } else {
      return const Left('Login gagal');
    }
  }
}
