import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:lms/src/features/http/provider/http_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/file.dart';

final fileProvider = Provider<FileApi>((ref) {
  return FileApi(ref.watch(httpProvider));
});

class FileApi {
  final IOClient client;
  FileApi(this.client);

  Future getFileFromUrl(FileModel document) async {
    Uri url = Uri.parse(
        "https://elearning.itg.ac.id/upload/materi/${document.namaFile}");

    final response = await client.get(url);
    final bytes = response.bodyBytes;
    Directory dir = await getApplicationDocumentsDirectory();
    List<String> urlName = (url.toString()).split("/");
    String name = urlName[urlName.length - 1];
    File file = File("${dir.path}/$name");
    File urlFile = await file.writeAsBytes(bytes);
    print(urlFile);
    await OpenFile.open(urlFile.path);
  }
}
