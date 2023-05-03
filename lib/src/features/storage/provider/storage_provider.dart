import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/storage.dart';
import '../../injection/provider/injection_provider.dart';

final storageProvider = Provider<SecureStorage>((ref) {
  final getIt = ref.watch(getItProvider);
  return getIt.get<SecureStorage>();
});
