import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/dashboard/provider/dashboard_state.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../core/utils/extentions/remove_scroll_grow.dart';
import '../../features/dashboard/provider/dashboard_notifier.dart';

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
    Future.microtask(() {
      final dashboardApi = ref.watch(dashboardNotifierProvider.notifier);
      dashboardApi.getDashboardData();
    });
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
    final isScrolled = ref.watch(scrollProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isScrolled
            ? Colors.white
            : Theme.of(context).scaffoldBackgroundColor,
        leadingWidth: 250,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const CircleAvatar(),
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Consumer(builder: (context, watch, child) {
            final dashboardApi = watch.watch(dashboardNotifierProvider);
            if (dashboardApi.isLoading) {
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
                const Text(
                  'Novan Noviansyah Pratama',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '1906038',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            );
          }),
        ),
        toolbarHeight: 100,
      ),
      body: ScrollConfiguration(
        behavior: RemoveScrollGlow(),
        child: Consumer(
          builder: (context, watch, child) {
            final state = watch.watch(dashboardNotifierProvider);
            if (state.isLoading) {
              return SingleChildScrollView(
                child: Column(
                  children: [Row()],
                ),
              );
            } else {
              if (state.data != null) {
                return Text(state.data!['tugas']['not_finished'].toString());
              } else {
                return Text(state.message.toString());
              }
            }
          },
        ),
      ),
    );
  }
}
