import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';
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
    this.buttonWidget,
    this.isDropdown = false,
  });

  final String containerTitle;
  final Widget containerChild;
  final String? footerTitle;
  final Widget? footerContent;
  final IconData? icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final Widget? buttonWidget;
  final bool isDropdown;

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
                  crossAxisAlignment: .center,
                  mainAxisSize: .max,
                  mainAxisAlignment: .spaceBetween,
                  spacing: AppSpacing.spacingM,
                  children: [
                    Expanded(
                      child: CustomText(
                        text: containerTitle.toUpperCase(),
                        textType: CustomTextType.smallHeading,
                      ),
                    ),
                    if (buttonWidget != null) ...[
                      Flexible(child: buttonWidget!),
                    ] else if (buttonText != null &&
                        onButtonPressed != null) ...[
                      Flexible(
                        child: AppButton.outlined(
                          size: AppButtonSize.regular,
                          iconAlignment: IconAlignment.end,
                          icon: isDropdown
                              ? Icons.keyboard_arrow_down_sharp
                              : Icons.arrow_outward,
                          text: buttonText!,
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
