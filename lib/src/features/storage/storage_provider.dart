import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/storage.dart';
import '../injection/injection_provider.dart';

final secureStorage = Provider<SecureStorage>((ref) {
  final getIt = ref.watch(getItProvider);
  return getIt.get<SecureStorage>();
});
