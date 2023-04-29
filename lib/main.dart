import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}
