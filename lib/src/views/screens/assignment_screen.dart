import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/core/style/theme.dart';
import 'package:lms/src/core/utils/extentions/check_status_tugas.dart';
import 'package:lms/src/core/utils/extentions/format_date.dart';
import 'package:lms/src/features/assigment/provider/assigment/assigment_provider.dart';

final scrollProvider = StateNotifierProvider<ScrollNotifier, bool>((ref) {
  return ScrollNotifier();
});

class ScrollNotifier extends StateNotifier<bool> {
  ScrollNotifier() : super(false);

  void changeIsButton(bool newvalue) => state = newvalue;
}

class AssignmentScreen extends ConsumerStatefulWidget {
  const AssignmentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssignmentScreenState();
}

class _AssignmentScreenState extends ConsumerState<AssignmentScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    Future.microtask(() {
      ref.watch(assigmentNotifierProvider.notifier).getAssigment();
    });
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
    final assigmentList = ref.watch(assigmentNotifierProvider).data;
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
                    Text("Tugas",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        )),
                  ],
                ),
              ),
              background: Image.asset(
                "assets/images/bg_tugas.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPersistentHeader(
              pinned: true,
              delegate: PersistentHeader(
                100,
                100,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text("Pilih Mata Kuliah : "),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
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
          SliverPersistentHeader(
              pinned: true,
              delegate: PersistentHeader(
                60,
                60,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
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
                        hint: const Text("Status Tugas"),
                        items: ["Semua status", "Belum selesai", "Selesai"]
                            .map((status) => DropdownMenuItem<String>(
                                  value: status,
                                  child: Text(status),
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
              assigmentList!.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: kGreenPrimary,
                      ),
                    )
                  : Column(
                      children: assigmentList
                          .map(
                            (assigment) => Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                              "${assigment.kelasMapel?.nama}",
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
                                      Column(
                                        children: [
                                          Column(
                                            children: [
                                              Text(formatDate(
                                                  assigment.createdAt!)),
                                              const SizedBox(height: 10),
                                              getAssigmentStatus(assigment)
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        if (assigment.isDone == 'y')
                                          const BannerGrade(
                                              "Dinilai", Colors.green),
                                        if (assigment.pesan!.isNotEmpty)
                                          const BannerGrade(
                                              "Pesan", Colors.yellow),
                                        if (assigment.isDone == 'n')
                                          const BannerGrade(
                                              "Belum dinilai", Colors.grey),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList())
            ]),
          ),
        ],
      ),
    );
  }
}

class BannerGrade extends StatelessWidget {
  const BannerGrade(
    this.text,
    this.color, {
    super.key,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          )),
    );
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double max;
  final double min;

  PersistentHeader(this.max, this.min, {required this.widget});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: widget,
    );
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
