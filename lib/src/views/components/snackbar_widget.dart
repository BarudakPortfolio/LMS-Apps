import 'package:flutter/material.dart';

SnackBar buildSnackBar(String message, Color color) {
  return SnackBar(
    content: Text(message),
    backgroundColor: color,
    duration: const Duration(seconds: 1),
  );
}
