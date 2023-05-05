import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:lms/src/core/common/constants.dart';
import 'package:lms/src/features/http/provider/http_provider.dart';
import 'package:lms/src/models/tugas.dart';

final assigmentProvider = Provider<AssigmentApi>((ref) {
  return AssigmentApi(client: ref.watch(httpProvider));
});

class AssigmentApi {
  final IOClient client;
  AssigmentApi({required this.client});

  Future<Either<String, List<Tugas>>> getAssigment(String token) async {
    Uri url = Uri.parse("$BASE_URL/student_area/tugas");

    final response = await client.get(url, headers: {
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['data'];
      List<Tugas> listAssigment =
          result.map((assigment) => Tugas.fromJson(assigment)).toList();
      return Right(listAssigment);
    }
    return const Left("Tugas Tidak Ada");
  }
}
