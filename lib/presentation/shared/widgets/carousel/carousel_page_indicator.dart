import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';

class CarouselPageIndicator extends StatelessWidget {
  final int indicatorsCount;
  final int currentIndex;

  const CarouselPageIndicator({
    super.key,
    required this.indicatorsCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: List.generate(
        indicatorsCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: currentIndex == index
              ? AppSizes.pageIndicatorActiveWidth
              : AppSizes.pageIndicatorWidth,
          height: AppSizes.pageIndicatorHeight,
          margin: .only(left: index == 0 ? 0 : AppSpacing.spacingS),
          decoration: BoxDecoration(
            borderRadius: AppBorders.mediumBorderRadius,
            color: context.colors.textHint.withValues(
              alpha: currentIndex == index ? 1 : 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
