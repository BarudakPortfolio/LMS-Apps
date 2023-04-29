import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (int newIndex) {},
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
      body: PageView(
        onPageChanged: (index) {},
        children: [],
      ),
    );
  }
}
