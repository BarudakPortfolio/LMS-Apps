import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/models/user.dart';
import 'package:lms/src/views/screens/materi_screen.dart';
import 'package:lms/src/views/screens/profile_screen.dart';

import '../../features/dashboard/provider/dashboard_provider.dart';
import '../../features/materi/provider/materi/materi_provider.dart';
import '../../features/user/provider/user_provider.dart';
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

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  bool isClickButton = false;
  @override
  void initState() {
    Future.microtask(() {
      UserModel? user = ref.watch(userNotifierProvider).user;
      ref.watch(dashboardNotifierProvider.notifier).getDashboardData();
      ref.watch(userNotifierProvider.notifier).getUser();
      ref.watch(materiNotifierProvider.notifier).getMateri();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(navProvider);
    return WillPopScope(
      onWillPop: () async {
        if (index == 0) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Yakin Keluar ?"),
                    content: const Text("Jika anda keluar, klik Ya."),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            SystemChannels.platform
                                .invokeMethod("SystemNavigator.pop");
                          },
                          child: const Text("Ya")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Tidak")),
                    ],
                  ));
        } else {
          ref.watch(navProvider.notifier).changeIndex(0);
        }
        return false;
      },
      child: Scaffold(
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
            children: const [
              DashboardScreen(),
              ClassScreen(),
              MateriScreen(),
              AssignmentScreen(),
              ProfileScreen(),
            ],
          )),
    );
  }
}
