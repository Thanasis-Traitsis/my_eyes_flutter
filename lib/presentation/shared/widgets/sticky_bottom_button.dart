import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';

class StickyBottomButton extends StatelessWidget {
  const StickyBottomButton({
    super.key,
    required this.buttonText,
    required this.isEnabled,
    required this.onTap,
  });

  final String buttonText;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacingM,
        vertical: AppSpacing.spacingL,
      ),
      decoration: BoxDecoration(
        color: context.colors.background,
        border: Border(
          top: BorderSide(
            width: AppBorders.smallBorderWidth,
            color: context.colors.black.withValues(alpha: 0.4),
          ),
        ),
      ),
      child: AppButton.filled(
        text: buttonText,
        onPressed: isEnabled ? onTap : null,
        size: AppButtonSize.large,
      ),
    );
  }
}
