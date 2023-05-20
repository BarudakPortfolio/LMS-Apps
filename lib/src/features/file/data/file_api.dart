import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:lms/src/features/http/provider/http_provider.dart';

final fileProvider = Provider<FileApi>((ref) {
  return FileApi(ref.watch(httpProvider));
});

class FileApi {
  final IOClient client;
  FileApi(this.client);
}
