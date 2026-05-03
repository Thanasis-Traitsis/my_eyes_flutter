import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.spacingM,
      crossAxisAlignment: .end,
      children: [
        Container(
          width: AppSizes.profileAvatarSize,
          height: AppSizes.profileAvatarSize,
          decoration: BoxDecoration(
            color: context.colors.white,
            borderRadius: AppBorders.mediumBorderRadius,
          ),
        ),
        OutlinedButton.icon(
          iconAlignment: .end,
          onPressed: () {},
          label: Text(AppStrings.profileButtonEditImage.toUpperCase()),
          icon: const Icon(Icons.edit, size: AppSizes.iconSizeS),
        ),
      ],
    );
  }
}
