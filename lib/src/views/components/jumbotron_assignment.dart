import 'package:flutter/material.dart';

import '../../core/style/theme.dart';
import '../../core/utils/extentions/check_status_tugas.dart';
import '../../core/utils/extentions/format_date.dart';
import '../../models/tugas.dart';

class JumbotronAssignment extends StatelessWidget {
  const JumbotronAssignment({
    super.key,
    required this.assignment,
  });

  final Tugas? assignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kGreenPrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text("${assignment?.detail?.judul}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "${assignment?.kelasMapel?.nama}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: kGreenPrimary,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${assignment?.detail?.mapel?.nama}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Tenggat : ",
                style: checkDeadlineAssigment(
                  assignment!,
                ),
              ),
              Text(
                " ${formatDatetimeNumber(assignment!.detail!.tanggalPengumpulan!)}",
                style: checkDeadlineAssigment(
                  assignment!,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
