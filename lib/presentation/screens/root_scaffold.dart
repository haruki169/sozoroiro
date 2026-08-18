import 'package:flutter/material.dart';

import 'diary/diary_screen.dart';
import 'home/home_screen.dart';
import 'map/map_screen.dart';
import 'settings/settings_screen.dart';

/// ボトムナビゲーション「ホーム／日記／地図／設定」の4destination（design.md 3章）。
class RootScaffold extends StatefulWidget {
  const RootScaffold({super.key});

  @override
  State<RootScaffold> createState() => _RootScaffoldState();
}

class _RootScaffoldState extends State<RootScaffold> {
  int _index = 0;

  static const _screens = [
    HomeScreen(),
    DiaryScreen(),
    MapScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'ホーム'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: '日記'),
          NavigationDestination(icon: Icon(Icons.map_outlined), label: '地図'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: '設定'),
        ],
      ),
    );
  }
}
