import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/core/routes/app_routes.dart';
import 'package:lms/src/core/style/theme.dart';
import 'package:lms/src/core/utils/extentions/format_date.dart';
import 'package:lms/src/core/utils/extentions/nama_dosen.dart';
import 'package:lms/src/core/utils/extentions/remove_scroll_grow.dart';

import '../../features/materi/provider/materi/materi_provider.dart';
import '../../models/materi.dart';
import 'main_screen.dart';

final scrollProvider = StateNotifierProvider<ScrollNotifier, bool>((ref) {
  return ScrollNotifier();
});

class ScrollNotifier extends StateNotifier<bool> {
  ScrollNotifier() : super(false);

  void changeIsButton(bool newvalue) => state = newvalue;
}

class MateriScreen extends ConsumerStatefulWidget {
  const MateriScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MateriScreenState();
}

class _MateriScreenState extends ConsumerState<MateriScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.offset >
          _scrollController.position.maxScrollExtent * 0.05) {
        ref.watch(scrollProvider.notifier).changeIsButton(true);
      } else {
        ref.watch(scrollProvider.notifier).changeIsButton(false);
      }
    });
    super.initState();
  }

  void scrollOnTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isScrolled = ref.watch(scrollProvider);
    final materiState = ref.watch(materiNotifierProvider);
    return Scaffold(
      floatingActionButton: isScrolled
          ? FloatingActionButton(
              elevation: 2,
              backgroundColor: Colors.white,
              foregroundColor: kGreenPrimary,
              child: const Icon(Icons.arrow_upward),
              onPressed: () => scrollOnTop(),
            )
          : const SizedBox(),
      body: CustomScrollView(
        controller: _scrollController,
        scrollBehavior: RemoveScrollGlow(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            pinned: true,
            collapsedHeight: 60,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              title: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(FluentIcons.book_24_regular),
                    SizedBox(width: 10),
                    Text("Materi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        )),
                  ],
                ),
              ),
              background: Image.asset(
                "assets/images/bg_materi.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPersistentHeader(
              pinned: true,
              delegate: PersistentHeader(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text("Pilih Mata Kuliah : "),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        menuMaxHeight: 250,
                        borderRadius: BorderRadius.circular(15),
                        iconEnabledColor: Colors.black,
                        isExpanded: true,
                        hint: const Text("Mata Kuliah"),
                        items: [
                          "Semua Mata Kuliah",
                          "Pemrograman Mobile",
                          "Matematika Diskrit"
                        ]
                            .map((kelas) => DropdownMenuItem<String>(
                                  value: kelas,
                                  child: Text(kelas),
                                ))
                            .toList(),
                        onChanged: (value) {},
                      )),
                    ),
                  ],
                ),
              )),
          SliverList(
            delegate: SliverChildListDelegate([
              Builder(
                builder: (context) {
                  if (materiState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (materiState.data != null) {
                      final data = materiState.data;
                      return Column(
                        children:
                            data!.map((e) => CardMateri(materi: e)).toList(),
                      );
                    } else {
                      return const Center(
                        child: Text('Materi tidak ada'),
                      );
                    }
                  }
                },
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class CardMateri extends StatelessWidget {
  final Materi materi;

  const CardMateri({super.key, required this.materi});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.detailMateri,
            arguments: materi.id);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${materi.judul}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )),
                      Text('${materi.mapel!.nama}',
                          style: TextStyle(color: Colors.grey[500])),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kGreenPrimary,
                  ),
                  child: Text(
                    'Pertemuan ${materi.pertemuanKe!}',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                )
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Icon(FluentIcons.person_16_regular),
                Text(
                  namaDosen(materi.kelasMapel!.guru!),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(FluentIcons.calendar_clock_20_regular),
                    const SizedBox(width: 3),
                    Text("${formatDate(materi.createdAt!)}",
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(FluentIcons.document_16_regular),
                    const SizedBox(width: 3),
                    Text("File : ${materi.file?.length}",
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeader({required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: widget,
    );
  }

  @override
  double get maxExtent => 100.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
