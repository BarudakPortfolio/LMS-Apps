import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:lms/src/core/common/constants.dart';
import 'package:lms/src/features/http/provider/http_provider.dart';
import 'package:lms/src/features/storage/provider/storage_provider.dart';
import 'package:lms/src/features/storage/service/storage.dart';
import 'package:lms/src/models/materi.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/file.dart';

final materiApiProvider = Provider<MateriApi>((ref) {
  return MateriApi(client: ref.watch(httpProvider));
});

class MateriApi {
  final IOClient client;
  MateriApi({required this.client});

  Future<Either<String, List<Materi>>> getMateri(String token) async {
    Uri url = Uri.parse("$BASE_URL/student_area/materi?perPage=100");
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

  Future<Either<String, Materi>> getMateriDetail(int id, String token) async {
    Uri url = Uri.parse("$BASE_URL/student_area/materi/$id");
    final headers = {"Authorization": "Bearer $token"};
    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      Materi materi = Materi.fromJson(result['data'], dataFoto: result['foto']);
      return Right(materi);
    } else {
      return const Left("Tidak ada Materi");
    }
  }

  Future getFileFromUrl(FileModel document) async {
    Uri url = Uri.parse(
      "https://elearning.itg.ac.id/upload/materi/${document.namaFile}",
    );
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final bytesBody = response.bodyBytes;
      final dir = await getApplicationDocumentsDirectory();
      String nameFile = document.namaFile!;
      File filePath = File("${dir.path}/$nameFile");

      File fileAsPath = await filePath.writeAsBytes(bytesBody);
      return fileAsPath.path;
    }
  }
}
