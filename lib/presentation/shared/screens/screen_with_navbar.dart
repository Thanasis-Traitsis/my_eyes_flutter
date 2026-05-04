import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/presentation/shared/widgets/bottom_navbar.dart';

class ScreenWithNavbar extends StatelessWidget {
  const ScreenWithNavbar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            navigationShell,
            Positioned(
              left: AppSpacing.spacingL,
              right: AppSpacing.spacingL,
              bottom: AppSpacing.spacingM,
              child: BottomNavbar(navigationShell: navigationShell),
            ),
          ],
        ),
      ),
    );
  }
}
