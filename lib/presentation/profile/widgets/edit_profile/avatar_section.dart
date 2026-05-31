import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key, this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.spacingM,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: AppBorders.mediumBorderRadius,
          child: avatarUrl != null
              ? Image.asset(
                  avatarUrl!,
                  width: AppSizes.profileAvatarSize,
                  height: AppSizes.profileAvatarSize,
                  fit: BoxFit.fitHeight,
                )
              : Container(
                  width: AppSizes.profileAvatarSize,
                  height: AppSizes.profileAvatarSize,
                  color: context.colors.white,
                ),
        ),
        AppButton.outlined(
          iconAlignment: IconAlignment.end,
          icon: Icons.edit,
          text: AppStrings.profileButtonEditImage,
          onPressed: () {},
        ),
      ],
    );
  }
}
