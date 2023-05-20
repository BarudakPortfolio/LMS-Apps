import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lms/src/core/utils/extentions/string_capitalize.dart';
import 'package:lms/src/features/kelas/provider/class_notifier.dart';
import 'package:lms/src/models/kelas.dart';
import 'package:lms/src/views/components/card_class.dart';
import 'package:time_planner/time_planner.dart';
import 'package:lms/src/core/utils/extentions/remove_scroll_grow.dart';

import '../../core/routes/app_routes.dart';
import '../../core/style/theme.dart';
import '../../core/utils/extentions/format_date.dart';
import '../../core/utils/extentions/nama_dosen.dart';
import 'main_screen.dart';

class ClassScreen extends ConsumerStatefulWidget {
  const ClassScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClassScreenState();
}

class _ClassScreenState extends ConsumerState<ClassScreen> {
  @override
  Widget build(BuildContext context) {
    final kelas = ref.watch(classNotifierProvider);
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
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
                        Text("Kelas",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ),
                  background: Image.asset(
                    "assets/images/bg.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: MyTabBarDelegate(
                    tabBar: TabBar(
                  padding: const EdgeInsets.all(10),
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Colors.white,
                  tabs: const [
                    Tab(text: "Daftar Kelas"),
                    Tab(text: "Jadwal Kelas"),
                  ],
                )),
              ),
            ];
          },
          body: TabBarView(children: [
            ScrollConfiguration(
              behavior: RemoveScrollGlow(),
              child: Builder(
                builder: (context) {
                  if (kelas.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (kelas.classes != null) {
                      final kelasList = kelas.classes;
                      // print(data);
                      return ListView.builder(
                        itemCount: kelasList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (kelasList.isEmpty) {
                            return const SizedBox
                                .shrink(); // don't show empty list
                          }
                          return CardClass(
                            kelas: kelasList[index],
                          );
                          ;
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Materi tidak ada'),
                      );
                    }
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ScrollConfiguration(
                behavior: RemoveScrollGlow(),
                child: Builder(builder: (context) {
                  return TimePlanner(
                    style: TimePlannerStyle(
                      horizontalTaskPadding: 5,
                      cellWidth: 200,
                    ),
                    headers: List.generate(7, (day) {
                      var datetime = DateTime(2023, 8, day);
                      String dayName =
                          DateFormat("EEEE", "id_ID").format(datetime);
                      return TimePlannerTitle(title: dayName);
                    }),
                    startHour: 7,
                    endHour: 19,
                    tasks: kelas.classes?.map((data) {
                      DateTime startTime =
                          DateTime.parse('1970-01-02 ${data.waktuMulai!}');
                      DateTime endTime =
                          DateTime.parse('1970-01-02 ${data.waktuSelesai!}');
                      Duration difference = endTime.difference(startTime);
                      int differenceInMinutes = difference.inMinutes;
                      int day = dayToNumber(data.hari!);
                      return TimePlannerTask(
                        minutesDuration: differenceInMinutes,
                        dateTime: TimePlannerDateTime(
                          day: day,
                          hour: startTime.hour,
                          minutes: startTime.minute,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(data.nama ?? "no name",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              subtitle: Text(
                                  "${data.waktuMulai!.substring(0, 5)} - ${data.waktuSelesai!.substring(0, 5)}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 10)),
                            )),
                        onTap: () {},
                      );
                    }).toList(),
                  );
                }),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class MyTabBarDelegate extends SliverPersistentHeaderDelegate {
  MyTabBarDelegate({required this.tabBar});

  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant MyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}

class CardClass extends StatelessWidget {
  final Kelas kelas;

  const CardClass({super.key, required this.kelas});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(10),
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
                          Text('${kelas.nama}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                          Text('${kelas.namaGuru}',
                              style: TextStyle(color: Colors.grey[500])),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kGreenPrimary,
                      ),
                      child: Text(
                        'Ruangan ${kelas.ruangan!}',
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(FluentIcons.calendar_clock_20_regular),
                        const SizedBox(width: 3),
                        Text(
                          '${kelas.hari!.toTitleCase()}, ${kelas.waktuMulai!.substring(0, 5)} - ${kelas.waktuSelesai!.substring(0, 5)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
