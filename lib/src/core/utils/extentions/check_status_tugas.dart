import 'package:flutter/material.dart';

changeIcon(isDone, tglUpload, deadline) {
  if (tglUpload != null) {
    var ddline = deadline.replaceAll(RegExp("-|:| "), "");
    var tglUp = tglUpload.replaceAll(RegExp("-|:| "), "");
    if (int.parse(tglUp) >= int.parse(ddline)) {
      return const Icon(
        Icons.av_timer,
        color: Colors.yellow,
        size: 20,
      );
    }
  } else if (isDone == "n") {
    return const Icon(
      Icons.close_rounded,
      color: Colors.red,
      size: 20,
    );
  }
  return const Icon(
    Icons.check_circle_outline_outlined,
    color: Colors.lightGreen,
    size: 20,
  );
}
