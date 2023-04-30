import 'package:flutter/material.dart';

class RemoveScrollGlow extends ScrollBehavior {
  @override
  Widget build(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
