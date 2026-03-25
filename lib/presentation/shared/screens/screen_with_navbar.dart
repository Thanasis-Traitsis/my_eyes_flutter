import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenWithNavbar extends StatelessWidget {
  const ScreenWithNavbar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_2_rounded),
            label: 'Eye Test',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye_outlined),
            label: 'Eyewear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
