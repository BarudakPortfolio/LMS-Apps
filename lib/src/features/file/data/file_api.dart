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
}
