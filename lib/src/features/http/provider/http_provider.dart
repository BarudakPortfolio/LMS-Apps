import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:lms/src/features/injection/provider/injection_provider.dart';

final httpProvider = Provider<IOClient>((ref) {
  final getIt = ref.watch(getItProvider);
  return getIt<IOClient>();
});
