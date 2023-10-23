import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/core/style/theme.dart';
import 'package:lms/src/features/assigment/provider/assigment/assigment_provider.dart';
import 'package:lms/src/features/kelas/provider/class_notifier.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/kelas.dart';
import '../components/card_assigment.dart';

final scrollProvider = StateProvider<bool>((ref) => false);

final dropdownStatusNotifierProvider = StateProvider<String>((ref) => "all");

final dropdownClassNotifierProvider = StateProvider<String>((ref) => "all");


class AssignmentScreen extends ConsumerStatefulWidget {
  const AssignmentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssignmentScreenState();
}

class _AssignmentScreenState extends ConsumerState<AssignmentScreen> {
  late ScrollController _scrollController;
  static const Map<String, String> statuses = {
    "Semua status": "all",
    "Belum Selesai": "n",
    "Selesai": "y",
  };

  @override
  void initState() {
    Future.microtask(() async {
      ref.watch(assigmentNotifierProvider.notifier).getAssigment(
            newStatus: "all",
            newMapelId: 'all',
          );
      if (await Permission.manageExternalStorage.isDenied) {
        await Permission.manageExternalStorage.request();
        await Permission.camera.request();
      }
    });
    _scrollController = ScrollController()
        ..addListener(() {
      if (_scrollController.offset >
          _scrollController.position.maxScrollExtent * 0.05) {
        ref.watch(scrollProvider.notifier).state = (true);
      } else {
        ref.watch(scrollProvider.notifier).state = (false);
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
    final status = ref.watch(dropdownStatusNotifierProvider);
    final classSelected = ref.watch(dropdownClassNotifierProvider);
    final listclass = ref.watch(classNotifierProvider).classes;
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
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1), () {
            ref.read(assigmentNotifierProvider.notifier).getAssigment(
                newStatus: status, newMapelId: classSelected);
          });
        },
        child: CustomScrollView(
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
                title: const SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        child: Text("Pilih Kategori Tugas : "),
                      ),
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          menuMaxHeight: 250,
                          borderRadius: BorderRadius.circular(15),
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          value: classSelected,
                          hint: const Text("Mata Kuliah"),
                          items: listclass == null
                              ? []
                              : [
                                  Kelas(id: "all", nama: "Semua mata kuliah"),
                                  ...listclass
                                ]
                                  .map((Kelas kelas) => DropdownMenuItem<String>(
                                        value: kelas.id,
                                        child: Text(kelas.nama!),
                                      ))
                                  .toList(),
                          onChanged: (mapelId) {
                            ref
                                .watch(assigmentNotifierProvider.notifier)
                                .getAssigment(
                                    newStatus: status,
                                    newMapelId: mapelId.toString());
                            ref
                                .watch(dropdownClassNotifierProvider.notifier)
                                .state = (mapelId.toString());
                          },
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
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          menuMaxHeight: 250,
                          borderRadius: BorderRadius.circular(15),
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          value: status,
                          hint: const Text("Status Tugas"),
                          items: statuses
                              .map((key, value) {
                                return MapEntry(
                                    key,
                                    DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(key),
                                    ));
                              })
                              .values
                              .toList(),
                          onChanged: (status) {
                            ref
                                .watch(assigmentNotifierProvider.notifier)
                                .getAssigment(
                                  newStatus: status,
                                  newMapelId: classSelected.toString(),
                                );
                            ref
                                .watch(dropdownStatusNotifierProvider.notifier)
                                .state = (status!);
                          },
                        )),
                      ),
                    ],
                  ),
                )),
            SliverList(
              delegate: SliverChildListDelegate([
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      if (ref.watch(assigmentNotifierProvider).isLoading)
                        const SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: kGreenPrimary,
                            ),
                          ),
                        )
                      else if (assigmentList != null &&
                          assigmentList.isNotEmpty)
                        Column(
                          children: assigmentList
                              .map(
                                (assigment) => CardAssigment(assigment),
                              )
                              .toList(),
                        )
                      else
                        const SizedBox(
                          height: 200,
                          child: Center(child: Text("Tugas tidak ada")),
                        )
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
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
