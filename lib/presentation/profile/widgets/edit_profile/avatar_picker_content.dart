import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_avatars.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';

class AvatarPickerContent extends StatelessWidget {
  const AvatarPickerContent({
    super.key,
    required this.selectedUrl,
    required this.onSelected,
  });

  final String? selectedUrl;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final avatars = AppAvatars.all;
    final selected = selectedUrl ?? avatars.first;

    return Column(
      spacing: AppSpacing.spacingM,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Container(
              key: ValueKey(selected),
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
              child: Image.asset(selected, fit: BoxFit.contain),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: AppSpacing.spacingM,
            children: avatars
                .map(
                  (url) => _AvatarThumbnail(
                    avatarUrl: url,
                    isSelected: url == selected,
                    onTap: () => onSelected(url),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _AvatarThumbnail extends StatelessWidget {
  const _AvatarThumbnail({
    required this.avatarUrl,
    required this.isSelected,
    required this.onTap,
  });

  final String avatarUrl;
  final bool isSelected;
  final VoidCallback onTap;

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
        padding: const EdgeInsets.all(AppSpacing.spacingS),
        child: Image.asset(avatarUrl, fit: BoxFit.contain),
      ),
    );
  }
}
