import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:lms/src/core/common/constants.dart';
import 'package:lms/src/features/http/provider/http_provider.dart';
import 'package:lms/src/models/tugas.dart';
import 'package:open_file/open_file.dart' as OpenFile;
import 'package:path_provider/path_provider.dart';

import '../../../models/file.dart';

final assigmentProvider = Provider<AssigmentApi>((ref) {
  return AssigmentApi(client: ref.watch(httpProvider));
});

class AssigmentApi {
  final IOClient client;
  AssigmentApi({required this.client});

  Future<Either<String, List<Tugas>>> getAssigment(String token,
      {String? mapelId, String? status}) async {
    mapelId ??= "all";
    status ??= "all";
    Uri url = Uri.parse(
      "$BASE_URL/student_area/tugas?mapel_id=$mapelId&is_done=$status",
    );

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

  Future<Either<String, Tugas>> getDetailAssigment(
    String token,
    String idTugas,
  ) async {
    Uri url = Uri.parse(
      "$BASE_URL/student_area/tugas/$idTugas",
    );

    final response = await client.get(url, headers: {
      "Authorization": "Bearer $token",
    });

    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body)['data'];
      Tugas assigment = Tugas.fromJson(result);
      return Right(assigment);
    }
    return const Left("Tugas Tidak Ada");
  }

  Future getFileFromUrl(FileModel document) async {
    Uri url = Uri.parse(
      "https://elearning.itg.ac.id/upload/tugas/${document.namaFile}",
    );
    final response = await client.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final bytesBody = response.bodyBytes;
      final dir = await getApplicationDocumentsDirectory();
      String nameFile = document.namaFile!;
      File filePath = File("${dir.path}/$nameFile");

      File fileAsPath = await filePath.writeAsBytes(bytesBody);
      final result = await OpenFile.OpenFile.open(fileAsPath.path);
      print(result.message);
    }
  }
}
