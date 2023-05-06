import 'package:dartz/dartz.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lms/src/core/common/constants.dart';
import 'package:lms/src/core/routes/app_routes.dart';
import 'package:lms/src/core/style/theme.dart';
import 'package:lms/src/core/utils/extentions/format_date.dart';
import 'package:lms/src/features/materi/data/materi_api.dart';
import 'package:lms/src/views/components/webview.dart';
import 'package:open_file/open_file.dart';

import '../../features/materi/provider/materi_detail/materi_detail_provider.dart';

class MateriDetailScreen extends ConsumerStatefulWidget {
  final int id;
  const MateriDetailScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MateriDetailScreenState();
}

class _MateriDetailScreenState extends ConsumerState<MateriDetailScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref
          .watch(materiDetailNotifierProvider.notifier)
          .getMateriDetail(widget.id)
          .then((value) {
        if (!value) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.cameraAutorisasi,
            arguments: widget.id.toString(),
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final materi = ref.watch(materiDetailNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Detail Materi"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text("Foto Autorisasi"),
                        content: Image.network(
                          "$BASE_IMAGE_URL${materi.data?.fotoAuth?.foto}",
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(
                              height: 100,
                              child: Center(child: Text("Gagal memuat foto")),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: kGreenPrimary,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Tutup"))
                        ],
                      ));
            },
            icon: const Icon(FluentIcons.video_person_16_regular),
          )
        ],
      ),
      body: materi.data == null
          ? const Center(
              child: CircularProgressIndicator(
                color: kGreenPrimary,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${materi.data!.judul}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text("${materi.data!.mapel!.nama}",
                                    style: TextStyle(color: Colors.grey[400])),
                                Text("${materi.data!.kelasMapel!.nama}",
                                    style: TextStyle(color: Colors.grey[400])),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                const Icon(
                                    FluentIcons.calendar_clock_16_regular),
                                Text(
                                  formatDateToNumber(materi.data!.createdAt!),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  const Text(
                    "Deskripsi : ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: HtmlWidget(
                      materi.data!.konten!,
                      enableCaching: true,
                      renderMode: RenderMode.column,
                      onTapUrl: (url) {
                        Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return WebViewScreen(url);
                            }));
                        return false;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("File Pendukung : "),
                  Column(
                    children: materi.data!.file!
                        .map((file) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                onTap: () async {
                                  ref
                                      .watch(materiApiProvider)
                                      .getFileFromUrl(file);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                tileColor: kGreenPrimary,
                                leading: const Icon(
                                  FluentIcons.document_16_regular,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  file.namaFile!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
    );
  }
}
