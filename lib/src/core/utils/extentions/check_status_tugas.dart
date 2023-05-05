import 'package:flutter/material.dart';

import '../../../models/tugas.dart';

Widget getAssigmentStatus(Tugas assignment) {
  if (assignment.isDone == 'y') {
    DateTime deadline = DateTime.parse(assignment.detail!.tanggalPengumpulan!);
    DateTime? userUpload = DateTime.parse(assignment.tanggalUpload!);

    if (userUpload.isAfter(deadline)) {
      return CircleAvatar(
        radius: 12,
        backgroundColor: Colors.yellow[400],
        child: Icon(
          Icons.watch_later_outlined,
          color: Colors.grey[500],
        ),
      );
    }
    return CircleAvatar(
      radius: 12,
      backgroundColor: Colors.green[400],
      child: const Icon(Icons.done, color: Colors.white),
    );
  }
  return CircleAvatar(
    radius: 12,
    backgroundColor: Colors.red[400],
    child: const Icon(
      Icons.close,
      color: Colors.white,
    ),
  );
}
