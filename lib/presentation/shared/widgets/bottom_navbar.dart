import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';

class BottomNavbar extends StatelessWidget {
  final StatefulNavigationShell? navigationShell;

  const BottomNavbar({super.key, this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(AppSpacing.spacingM),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppBorders.largeBorderRadius,
        boxShadow: [
          BoxShadow(
            color: context.colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: .spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            index: 0,
            navigationShell: navigationShell,
          ),
          _NavItem(
            icon: Icons.filter_2_rounded,
            label: 'Eye Test',
            index: 1,
            navigationShell: navigationShell,
          ),
          _NavItem(
            icon: Icons.remove_red_eye_outlined,
            label: 'Eyewear',
            index: 2,
            navigationShell: navigationShell,
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            index: 3,
            navigationShell: navigationShell,
          ),
        ].map((item) => Expanded(child: item)).toList(),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    this.navigationShell,
  });

  final IconData icon;
  final String label;
  final int index;
  final StatefulNavigationShell? navigationShell;

  @override
  Widget build(BuildContext context) {
    final isSelected = navigationShell?.currentIndex == index;
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5);

    return GestureDetector(
      onTap: () => navigationShell?.goBranch(
        index,
        initialLocation: index == navigationShell?.currentIndex,
      ),
      child: Center(
        child: AnimatedContainer(
          width: double.infinity,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: .symmetric(
            horizontal: isSelected ? AppSpacing.spacingM : AppSpacing.spacingS,
            vertical: AppSpacing.spacingXS,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: AppBorders.mediumBorderRadius,
          ),
          child: Column(
            mainAxisSize: .min,
            spacing: AppSpacing.spacingXS,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(icon, color: color, key: ValueKey(isSelected)),
              ),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                child: Text(label, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
