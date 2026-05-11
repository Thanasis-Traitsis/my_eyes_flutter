import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/presentation/shared/widgets/bottom_navbar.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_floating_button.dart';

class FloatingButtonSection extends StatelessWidget {
  const FloatingButtonSection({
    super.key,
    required this.buttonText,
    this.buttonIcon,
    required this.onTap,
  });

  final String buttonText;
  final IconData? buttonIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      right: AppSpacing.spacingL,
      left: AppSpacing.spacingL,
      child: Column(
        mainAxisAlignment: .end,
        crossAxisAlignment: .end,
        children: [
          CustomFloatingButton(
            buttonText: buttonText,
            buttonIcon: buttonIcon,
            onTap: onTap,
          ),
          Opacity(
            opacity: 0,
            child: Padding(
              padding: const .symmetric(vertical: AppSpacing.spacingM),
              child: BottomNavbar(),
            ),
          ),
        ],
      ),
    );
  }
}
