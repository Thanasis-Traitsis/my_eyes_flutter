import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.containerTitle,
    required this.containerChild,
    this.footerTitle,
    this.footerContent,
    this.icon,
    this.buttonText,
    this.onButtonPressed,
  });

  final String containerTitle;
  final Widget containerChild;
  final String? footerTitle;
  final Widget? footerContent;
  final IconData? icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(AppSpacing.spacingL),
      decoration: BoxDecoration(
        color: context.colors.divider,
        borderRadius: AppBorders.largeBorderRadius,
      ),
      child: Row(
        spacing: AppSpacing.spacingM,
        crossAxisAlignment: .start,
        children: [
          if (icon case final iconData?)
            Container(
              padding: .all(AppSpacing.spacingM),
              decoration: BoxDecoration(
                color: context.colors.white,
                borderRadius: AppBorders.mediumBorderRadius,
              ),
              child: Icon(iconData, size: AppSizes.iconSizeL),
            ),
          Expanded(
            child: Column(
              spacing: AppSpacing.spacingS,
              crossAxisAlignment: .start,
              children: [
                Row(
                  crossAxisAlignment: .start,
                  mainAxisSize: .max,
                  children: [
                    Expanded(
                      child: CustomText(
                        text: containerTitle.toUpperCase(),
                        textType: CustomTextType.smallHeading,
                      ),
                    ),
                    if (buttonText != null && onButtonPressed != null) ...[
                      SizedBox(width: AppSpacing.spacingM),
                      IntrinsicWidth(
                        child: OutlinedButton.icon(
                          iconAlignment: IconAlignment.end,
                          icon: const Icon(
                            Icons.arrow_outward,
                            size: AppSizes.iconSizeS,
                          ),
                          label: Text(buttonText!.toUpperCase()),
                          onPressed: onButtonPressed,
                        ),
                      ),
                    ],
                  ],
                ),
                containerChild,
                if (footerTitle != null && footerContent != null)
                  Column(
                    crossAxisAlignment: .start,
                    spacing: AppSpacing.spacingS,
                    children: [
                      CustomText(
                        text: footerTitle!.toUpperCase(),
                        textType: CustomTextType.smallHeading,
                      ),
                      footerContent!,
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
