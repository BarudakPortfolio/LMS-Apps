import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/time_planner.dart';
import 'package:lms/src/core/utils/extentions/remove_scroll_grow.dart';

class ClassScreen extends ConsumerStatefulWidget {
  const ClassScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClassScreenState();
}

class _ClassScreenState extends ConsumerState<ClassScreen> {
  @override
  Widget build(BuildContext context) {
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
                floating: true,
                collapsedHeight: 80,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.3,
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
                delegate: MyTabBarDelegate(
                    tabBar: TabBar(
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
                pinned: true,
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TabBarView(children: [
              ScrollConfiguration(
                behavior: RemoveScrollGlow(),
                child: ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    tileColor: Colors.white,
                    title: Text("Nama"),
                    subtitle: Text("waktu"),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ScrollConfiguration(
                  behavior: RemoveScrollGlow(),
                  child: TimePlanner(
                    style: TimePlannerStyle(
                      showScrollBar: true,
                      horizontalTaskPadding: 5,
                      cellWidth: 120,
                    ),
                    headers: List.generate(7, (day) {
                      var datetime = DateTime(2023, 8, day);
                      String dayName =
                          DateFormat("EEEE", "id_ID").format(datetime);
                      return TimePlannerTitle(title: dayName);
                    }),
                    startHour: 7,
                    endHour: 19,
                    tasks: [
                      TimePlannerTask(
                        color: Colors.green,
                        minutesDuration: 90,
                        dateTime:
                            TimePlannerDateTime(day: 0, hour: 8, minutes: 0),
                        child: const ListTile(
                          title: Text("Nama Kelas"),
                          subtitle:
                              Text("jam - jam", style: TextStyle(fontSize: 10)),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
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