import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:lms/src/core/common/constants.dart';
import 'package:lms/src/features/http/provider/http_provider.dart';
import 'package:lms/src/features/storage/provider/storage_provider.dart';
import 'package:lms/src/features/storage/service/storage.dart';

final autorisasiProvider = Provider<AutorisasiApi>((ref) {
  return AutorisasiApi(
    client: ref.watch(httpProvider),
    storage: ref.watch(storageProvider),
  );
});

class AutorisasiApi {
  final IOClient client;
  final SecureStorage storage;

  AutorisasiApi({required this.client, required this.storage});

  Future sendAutorisasi({
    String? id,
    String? type,
    File? foto,
  }) async {
    final token = await storage.read('token');
    List<int> imageBytes = await foto!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print(base64Image);
    Uri url = Uri.parse("$BASE_URL/student_area/$type/foto_siswa");
    print(url);
    Map<String, dynamic> data = {
      "avatar": "data:image/jpeg;base64,$base64Image",
      "${type}_id": id,
    };
    print(data);
    final response = await client.post(url, body: data, headers: {
      "Authorization": "Bearer $token",
    });
    print(response.body);
    final result = jsonDecode(response.body);
    if (result['status'] == 1) {
      return true;
    } else {
      return false;
    }
  }
}
