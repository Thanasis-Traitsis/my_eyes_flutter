import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class ToggleOption extends StatelessWidget {
  const ToggleOption({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacingL,
            vertical: AppSpacing.spacingM,
          ),
          decoration: BoxDecoration(
            color: isSelected ? context.colors.textPrimary : Colors.transparent,
            borderRadius: AppBorders.mediumBorderRadius,
          ),
          child: CustomText(
            text: label.toUpperCase(),
            textType: CustomTextType.regularButtonText,
            color: isSelected
                ? context.colors.white
                : context.colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
