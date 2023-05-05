import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:lms/src/features/http/provider/http_provider.dart';

import '../../../core/common/constants.dart';
import '../../../models/kelas.dart';

final classApiProvider = Provider<ClassApi>((ref) {
  return ClassApi(ref.watch(httpProvider));
});

class ClassApi {
  final IOClient client;

  ClassApi(this.client);

  Future<Either<String, List<Kelas>>> getAllClass(String token) async {
    Uri url = Uri.parse("$BASE_URL/student_area/jadwal");
    final headers = {"Authorization": "Bearer $token"};
    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body)["data"];
      List kelasPerDay = result.values.expand((element) => element).toList();

      Map<String, dynamic> uniqueMaps = {};

      for (var map in kelasPerDay) {
        if (!uniqueMaps.containsKey(
            '${map['kelas_mapel']['mapel']['nama']}-${map['hari']}')) {
          uniqueMaps[map['kelas_mapel']['mapel']['nama']] = map;
        }
      }

      List uniqueList = uniqueMaps.values.toList();

      List<Kelas> convertMapToKelas =
          uniqueList.map((e) => Kelas.fromJson(e)).toList();

      return Right(convertMapToKelas);
    } else {
      return const Left("Tidak ada Materi");
    }
  }
}
