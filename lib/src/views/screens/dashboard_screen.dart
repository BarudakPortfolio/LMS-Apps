import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/core/style/theme.dart';
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userApi.user?.name ?? 'No Name',
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
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FluentIcons.alert_12_regular,
                          color: kGreenPrimary,
                        )),
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
            } else {
              if (state.data != null) {
                int totalMateri = state.data!['materi']['total'];
                int totalTugas = state.data!['tugas']['not_finished'];
                int totalAbsensi = state.data!['absensi']['report']['hadir'];
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Container(
                        // width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: kGreenPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              flex: 2,
                              child: ListTile(
                                title: Text("ELearning ITG",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                                subtitle: Text(
                                  "Layanan Digitalisasi Sekolah",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              child:
                                  Image.asset("assets/images/bg_book_lamp.png"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CardSummary(
                              "Materi",
                              totalMateri,
                              onTap: () {
                                ref.watch(navProvider.notifier).changeIndex(2);
                              },
                            ),
                            CardSummary(
                              "Tugas",
                              totalTugas,
                              onTap: () {
                                ref.watch(navProvider.notifier).changeIndex(3);
                              },
                            ),
                            CardSummary(
                              "Hadir",
                              totalAbsensi,
                              onTap: () {
                                ref.watch(navProvider.notifier).changeIndex(0);
                              },
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            title: const Text(
                              "Kelas Hari ini",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: TextButton(
                              onPressed: () {
                                ref.watch(navProvider.notifier).changeIndex(1);
                              },
                              child: const Text("Lihat Semua"),
                            ),
                          ),
                          SizedBox(
                            width: size.width,
                            height: 250,
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 20,
                                    ),
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return const SizedBox(width: 10);
                                  } else {
                                    return const CardClass();
                                  }
                                }),
                          )
                        ],
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
