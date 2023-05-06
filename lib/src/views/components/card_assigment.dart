import 'package:flutter/material.dart';

import '../../core/utils/extentions/check_status_tugas.dart';
import '../../core/utils/extentions/format_date.dart';
import '../../models/tugas.dart';
import 'banner_grade.dart';

class CardAssigment extends StatelessWidget {
  Tugas assigment;
  CardAssigment(
    this.assigment, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ListTile(
                  title: Text("${assigment.detail?.mapel?.nama}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text(
                    "${assigment.detail?.judul}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(formatDateToNumber(assigment.createdAt!),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                            )),
                        const SizedBox(height: 10),
                        getAssigmentStatus(assigment)
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                if (assigment.isDone == 'y')
                  const BannerGrade("Dinilai", Colors.green),
                if (assigment.pesan != null)
                  const BannerGrade("Pesan", Colors.yellow),
                if (assigment.isDone == 'n')
                  const BannerGrade("Belum dinilai", Colors.grey),
              ],
            ),
          )
        ],
      ),
    );
  }
}
