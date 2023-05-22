import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lms/src/core/style/theme.dart';
import 'package:lms/src/features/assigment/provider/assigment/assigment_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../features/assigment/provider/assigment_detail/assigment_detail_provider.dart';
import '../components/jumbotron_assignment.dart';

class AssignmentDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const AssignmentDetailScreen(this.id, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssignmentDetailScreenState();
}

class _AssignmentDetailScreenState
    extends ConsumerState<AssignmentDetailScreen> {
  late TextEditingController _linkDownloadCtrl;
  late TextEditingController _linkYoutubeCtrl;
  @override
  void initState() {
    Future.microtask(() async {
      await ref
          .watch(detailAssignmentNotifierProvider.notifier)
          .getDetailAssignment(
            widget.id,
          );
    });
    _linkDownloadCtrl = TextEditingController();
    _linkYoutubeCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _linkDownloadCtrl.dispose();
    _linkYoutubeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final archiveAssignment = ref.watch(archiveAssigmentNotifier);
    final state = ref.watch(detailAssignmentNotifierProvider);
    final assignment = state.data;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text("Foto Autorisasi"),
                        content: Image.network(
                          "https://elearning.itg.ac.id/${assignment!.foto}",
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
            icon: const Icon(FluentIcons.video_person_12_regular),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(FluentIcons.info_12_regular),
          // )
        ],
      ),
      body: state.isLoading && state.data == null
          ? Center(
              child: LoadingAnimationWidget.waveDots(
                  size: 40, color: Theme.of(context).primaryColor),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (assignment != null)
                        JumbotronAssignment(assignment: assignment),
                      // SizedBox(
                      //   height: 200,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: const [
                      //       Icon(
                      //         FluentIcons.airplane_take_off_24_filled,
                      //         size: 40,
                      //       ),
                      //       Text('On Progress')
                      //     ],
                      //   ),
                      // ),
                      Card(
                        color: kGreenPrimary,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("File Tambahan :",
                                  style:
                                      TextStyle(color: theme.primaryColorDark)),
                              assignment!.detail!.image == null ||
                                      assignment.detail!.image!.isEmpty
                                  ? Text("Tidak ada File",
                                      style: TextStyle(
                                          color: theme.primaryColorDark))
                                  : Column(
                                      children: List.generate(
                                          assignment.detail!.image!.length,
                                          (index) => Card(
                                                child: ListTile(
                                                  onTap: () {},
                                                  leading: const Icon(
                                                      Icons.file_copy),
                                                  title: Text(
                                                    assignment.detail!
                                                        .image![index].image!,
                                                  ),
                                                ),
                                              )),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide())),
                                  child: const Text(
                                    "Instruksi Tugas",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: HtmlWidget(
                                  assignment.detail!.konten!,
                                  // onTapUrl: (p0) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                backgroundColor: kGreenPrimary,
                              ),
                              onPressed: () {
                                ref
                                    .watch(archiveAssigmentNotifier.notifier)
                                    .addArchiveAssigment();
                              },
                              child: const Text("+ Lampirkan Tugas"),
                            ),
                            const Text(
                                "*File yang dapat di upload hanya format pdf, png, jpg,",
                                style: TextStyle(fontSize: 12))
                          ],
                        ),
                      ),
                      Column(
                        children: List.generate(
                            archiveAssignment.length,
                            (index) => Slidable(
                                  startActionPane: ActionPane(
                                      motion: const DrawerMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            ref
                                                .watch(archiveAssigmentNotifier
                                                    .notifier)
                                                .removeArchiveAssigment(
                                                    archiveAssignment[index]
                                                        ['id']);
                                          },
                                          backgroundColor: Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ]),
                                  child: archiveAssignment[index]['widget'],
                                )),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Lampirkan Link Pengerjaan : "),
                            TextFormField(
                              controller: _linkYoutubeCtrl,
                              decoration: InputDecoration(
                                  hintText: "Masukkan Link Drive",
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _linkDownloadCtrl,
                              decoration: InputDecoration(
                                  hintText: "Masukkan Link Donwload",
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: kGreenPrimary),
                          onPressed: () {},
                          child: const Text(
                            "Kirim",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100)
                    ],
                  )),
            ),
    );
  }
}
