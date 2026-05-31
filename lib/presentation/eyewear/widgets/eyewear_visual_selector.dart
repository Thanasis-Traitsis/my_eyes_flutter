import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class EyewearVisualSelector extends StatelessWidget {
  const EyewearVisualSelector({
    super.key,
    required this.category,
    required this.selectedIndex,
    required this.onSelected,
  });

  final EyewearCategory category;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final paths = category.imagePaths;

    return Column(
      spacing: AppSpacing.spacingM,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: AppStrings.eyewearVisualSelectorHint,
          textType: CustomTextType.smallBody,
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Container(
              key: ValueKey('${category.name}_$selectedIndex'),
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.colors.white,
                borderRadius: AppBorders.largeBorderRadius,
                border: Border.all(
                  width: AppBorders.smallBorderWidth,
                  color: context.colors.textPrimary.withValues(alpha: 0.6),
                ),
              ),
              padding: const EdgeInsets.all(AppSpacing.spacingL),
              child: Image.asset(paths[selectedIndex], fit: BoxFit.contain),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: AppSpacing.spacingM,
            children: List.generate(
              paths.length,
              (index) => _Thumbnail(
                isSelected: index == selectedIndex,
                onTap: () => onSelected(index),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.spacingS),
                  child: Image.asset(paths[index], fit: BoxFit.contain),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: AppSizes.minTouchableArea,
        height: AppSizes.minTouchableArea,
        decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: AppBorders.smallBorderRadius,
          border: Border.all(
            color: isSelected ? context.colors.primary : context.colors.divider,
            width: isSelected
                ? AppBorders.mediumBorderWidth
                : AppBorders.smallBorderWidth,
          ),
        ),
        child: child,
      ),
    );
  }
}
