import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:lms/src/core/common/constants.dart';
import 'package:lms/src/features/http/provider/http_provider.dart';
import 'package:lms/src/features/storage/provider/storage_provider.dart';
import 'package:lms/src/features/storage/service/storage.dart';
import 'package:lms/src/models/materi.dart';

final materiApiProvider = Provider<MateriApi>((ref) {
  return MateriApi(
      client: ref.watch(httpProvider), storage: ref.watch(storageProvider));
});

class MateriApi {
  final IOClient client;
  final SecureStorage storage;
  MateriApi({required this.client, required this.storage});

  Future<Either<String, List<Materi>>> getMateri() async {
    Uri url = Uri.parse("$baseUrl/student_area/materi");
    final token = await storage.read('token');
    final headers = {"Authorization": "Bearer $token"};
    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)["data"];
      List<Materi> listMateri = result.map((e) => Materi.fromJson(e)).toList();
      return Right(listMateri);
    } else {
      return const Left("Tidak ada Materi");
    }
  }
}
