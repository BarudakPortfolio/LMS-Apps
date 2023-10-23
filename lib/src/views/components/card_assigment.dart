import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/src/features/assigment/provider/assigment/assigment_provider.dart';

import '../../core/utils/extentions/check_status_tugas.dart';
import '../../core/utils/extentions/format_date.dart';
import '../../models/tugas.dart';
import 'banner_grade.dart';

class CardAssigment extends ConsumerWidget {
  final Tugas assigment;

  const CardAssigment(this.assigment, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height * 0.15,
      child: InkWell(
        onTap: () {
          if (assigment.foto == null) {
            context.pushNamed(
              'camera-auth',
              pathParameters: {'id': assigment.id.toString()},
              extra: true,
            );
          } else {
            context.pushNamed(
              'assignment-detail',
              pathParameters: {'id': assigment.id.toString()},
            ).then(
              (value) => ref
                  .watch(archiveAssigmentNotifier.notifier)
                  .clearArchiveAssignment(),
            );
          }
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ListTile(
                        title: Text("${assigment.detail?.mapel?.nama}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        subtitle: Text(
                          "${assigment.detail?.judul}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                  formatDateToNumber(
                                      assigment.detail!.tanggalPengumpulan!),
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
          ),
        ),
      ),
    );
  }
}
