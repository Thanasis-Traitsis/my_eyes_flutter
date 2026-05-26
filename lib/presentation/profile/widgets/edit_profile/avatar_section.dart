import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';

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
        AppButton.outlined(
          iconAlignment: .end,
          icon: Icons.edit,
          text: AppStrings.profileButtonEditImage,
          onPressed: () {},
        ),
      ],
    );
  }
}
