import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'assignment_screen.dart';
import 'class_screen.dart';
import 'dashboard_screen.dart';

final navProvider = StateNotifierProvider<NavProvider, int>((ref) {
  return NavProvider();
});

class NavProvider extends StateNotifier<int> {
  NavProvider() : super(0);

  void changeIndex(newIndex) => state = newIndex;
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navProvider);
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (int newIndex) {
            ref.watch(navProvider.notifier).changeIndex(newIndex);
          },
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey.shade400,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.glance_24_regular),
              activeIcon: Icon(FluentIcons.glance_24_filled),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.class_24_regular),
              activeIcon: Icon(FluentIcons.class_24_filled),
              label: 'Kelas',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.book_20_regular),
              activeIcon: Icon(FluentIcons.book_20_filled),
              label: 'Materi',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.clipboard_note_20_regular),
              activeIcon: Icon(FluentIcons.clipboard_note_20_filled),
              label: 'Tugas',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.person_20_regular),
              activeIcon: Icon(FluentIcons.person_20_filled),
              label: 'Profil',
            ),
          ],
        ),
        body: IndexedStack(
          index: index,
          children: [DashboardScreen(), ClassScreen(), AssignmentScreen()],
        ));
  }
}
