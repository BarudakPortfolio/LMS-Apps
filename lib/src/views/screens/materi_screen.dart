import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/core/style/theme.dart';

class MateriScreen extends ConsumerStatefulWidget {
  const MateriScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MateriScreenState();
}

class _MateriScreenState extends ConsumerState<MateriScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
              "assets/images/bg_materi.png",
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              children: List.generate(
                20,
                (index) => Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text("Nama Judul Materi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        subtitle: const Text(
                          "Deskripsi materi kali ini adalah baca sampai dengan selesai yaa",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Column(
                          children: const [
                            Text("Selasa", style: TextStyle(fontSize: 12)),
                            Text("27 Apr 2023", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: kGreenPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Nama dosen nya gaes",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ],
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
