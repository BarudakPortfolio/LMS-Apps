import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/core/style/theme.dart';
import 'package:lms/src/core/utils/extentions/format_date.dart';
import 'package:lms/src/views/screens/main_screen.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../core/utils/extentions/remove_scroll_grow.dart';
import '../../features/dashboard/provider/dashboard_provider.dart';
import '../../features/user/provider/user_provider.dart';
import '../../models/user.dart';
import '../components/card_class.dart';
import '../components/card_summary.dart';

final scrollProvider = StateNotifierProvider<ScrollProvider, bool>((ref) {
  return ScrollProvider();
});

class ScrollProvider extends StateNotifier<bool> {
  ScrollProvider() : super(false);
  void scrolled(newState) => state = newState;
}

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 0);
    _scrollController.addListener(() {
      if (_scrollController.offset > 0) {
        ref.watch(scrollProvider.notifier).scrolled(true);
      } else if (_scrollController.offset <= 0) {
        ref.watch(scrollProvider.notifier).scrolled(false);
      }
    });

    super.initState();
  }

  List<String> getWeekdays() {
    List<String> weekdays = [];
    DateTime today = DateTime.now();
    int mondayIndex = today.weekday - 1; // Hari Senin memiliki indeks 0
    DateTime monday = today.subtract(Duration(days: mondayIndex));

    for (int i = 0; i < 7; i++) {
      DateTime currentDay = monday.add(Duration(days: i));
      weekdays.add(currentDay.toString());
    }

    return weekdays;
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = ref.watch(dashboardNotifierProvider);
    final user = ref.watch(userNotifierProvider);
    Size size = MediaQuery.of(context).size;
    final isScrolled = ref.watch(scrollProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isScrolled
            ? Colors.white
            : Theme.of(context).scaffoldBackgroundColor,
        leadingWidth: 250,
        toolbarHeight: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Consumer(builder: (context, watch, child) {
            final dashboardApi = watch.watch(dashboardNotifierProvider);
            final userApi = watch.watch(userNotifierProvider);
            if (dashboardApi.isLoading && userApi.isLoading) {
              return appBarLoading();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, ${userApi.user?.name}' ?? 'No Name',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  userApi.user?.nim ?? '0000000',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            );
          }),
        ),
        actions: dashboard.isLoading && user.isLoading
            ? [
                Shimmer(
                    child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.grey[200],
                )),
                Shimmer(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[200],
                  ),
                ))
              ]
            : [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          ref.watch(navProvider.notifier).changeIndex(4);
                        },
                        child: avatarBuilder(user.user),
                      ),
                    ),
                  ],
                )
              ],
      ),
      body: ScrollConfiguration(
        behavior: RemoveScrollGlow(),
        child: Consumer(
          builder: (context, watch, child) {
            final state = watch.watch(dashboardNotifierProvider);
            if (state.isLoading) {
              return loadingDashboard();
            } else {
              if (state.data != null) {
                int totalMateri = state.data!['materi']['total'];
                int totalTugas = state.data!['tugas']['not_finished'];
                int totalAbsensi = state.data!['absensi']['report']['hadir'];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      const SliverToBoxAdapter(
                        child: Text(
                          'Hari ini',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      SliverGrid.builder(
                        itemCount: 7,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 4 / 5,
                                crossAxisCount: DateTime.daysPerWeek,
                                crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          DateTime today = DateTime.now();
                          DateTime sevenDays =
                              DateTime.now().add(const Duration(days: 7));

                          List<DateTime> listDate = [];
                          for (var date = today;
                              date.isBefore(sevenDays);
                              date = date.add(const Duration(days: 1))) {
                            listDate.add(date);
                          }

                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: formatBornDate(getWeekdays()[index]) ==
                                      formatBornDate(today.toString())
                                  ? const Color(0xff5CB4D2)
                                  : const Color(0xffd9d9d9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  formatDayToNumber(getWeekdays()[index]),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  formatDay(getWeekdays()[index])
                                      .substring(0, 3),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SliverToBoxAdapter(
                          child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    'Jam Masuk',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(state.data!['absensi']['today']
                                      ['jam_masuk'])
                                ],
                              ),
                              const SizedBox(
                                  height: 20, child: VerticalDivider()),
                              Column(
                                children: [
                                  const Text('Jam Keluar',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(state.data!['absensi']['today']
                                      ['jam_keluar'])
                                ],
                              ),
                            ]),
                      )),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: buildDashboard(
                            totalMateri, totalTugas, totalAbsensi, size),
                      )
                    ],
                  ),
                );
              } else {
                return Text(state.message.toString());
              }
            }
          },
        ),
      ),
    );
  }

  Column buildDashboard(
      int totalMateri, int totalTugas, int totalAbsensi, Size size) {
    return Column(
      children: [
        CardSummary(
          "Materi",
          totalMateri,
          onTap: () {
            ref.watch(navProvider.notifier).changeIndex(2);
          },
          icon: Icon(
            Icons.ac_unit,
            color: Theme.of(context).primaryColor,
          ),
        ),
        CardSummary(
          "Tugas",
          totalTugas,
          onTap: () {
            ref.watch(navProvider.notifier).changeIndex(3);
          },
          icon: Icon(
            Icons.ac_unit,
            color: Theme.of(context).primaryColor,
          ),
        ),
        CardSummary(
          "Hadir",
          totalAbsensi,
          onTap: () {
            ref.watch(navProvider.notifier).changeIndex(0);
          },
          icon: Icon(
            Icons.ac_unit,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Kelas Hari ini",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref.watch(navProvider.notifier).changeIndex(1);
                  },
                  child: const Text(
                    "Lihat Semua",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: size.width,
              height: 250,
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const SizedBox(width: 0);
                    } else {
                      return const CardClass();
                    }
                  }),
            )
          ],
        )
      ],
    );
  }

  SingleChildScrollView loadingDashboard() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Shimmer(
            child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (index) => Shimmer(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer(
                        child: Container(
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      ),
                    )),
                    Shimmer(
                        child: Container(
                      width: 70,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      ),
                    )),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index) {
                    if (index == 0) {
                      return const SizedBox(width: 10);
                    } else {
                      return Shimmer(
                          child: Container(
                        height: 200,
                        width: 180,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300,
                        ),
                      ));
                    }
                  }),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Column appBarLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer(
          child: Container(
            height: 10,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade300,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Shimmer(
          child: Container(
            height: 10,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ],
    );
  }

  Widget avatarBuilder(UserModel? user) {
    if (user?.avatar == null) {
      return const CircleAvatar(
        backgroundColor: kGreenPrimary,
        child: Icon(
          FluentIcons.person_20_regular,
          color: Colors.white,
        ),
      );
    } else {
      return CircleAvatar(
        backgroundImage: NetworkImage(
          'https://elearning.itg.ac.id/upload/avatar/${user!.avatar}',
        ),
      );
    }
  }
}
