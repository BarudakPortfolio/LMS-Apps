import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/extentions/remove_scroll_grow.dart';

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
          child: Column(
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
          ),
        ),
        toolbarHeight: 100,
      ),
      body: ScrollConfiguration(
        behavior: RemoveScrollGlow(),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: List.generate(
                20,
                (index) => ListTile(
                      title: Text(index.toString()),
                    )),
          ),
        ),
      ),
    );
  }
}
