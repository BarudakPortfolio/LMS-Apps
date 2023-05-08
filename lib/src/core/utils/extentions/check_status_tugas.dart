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

TextStyle checkDeadlineAssigment(Tugas assignment) {
  String date = assignment.detail!.tanggalPengumpulan!;
  DateTime datetimeAssignment = DateTime.parse(date);
  DateTime dateTimeNow = DateTime.now();
  if (assignment.isDone == 'y') {
    return const TextStyle(
      color: Colors.greenAccent,
      fontWeight: FontWeight.bold,
    );
  } else if (dateTimeNow.isAfter(datetimeAssignment)) {
    return const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
    );
  } else if (datetimeAssignment.difference(dateTimeNow).inDays < 15) {
    return const TextStyle(
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
    );
  }
  return const TextStyle(
    color: Colors.white,
  );
}
