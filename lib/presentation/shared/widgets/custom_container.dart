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
    this.buttonIcon = Icons.arrow_outward,
    this.backgroundColor,
    this.iconColor,
    this.iconBackgroundColor,
    this.borderColor,
  });

  final String containerTitle;
  final Widget containerChild;
  final String? footerTitle;
  final Widget? footerContent;
  final IconData? icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final Widget? buttonWidget;
  final IconData? buttonIcon;
  final bool isDropdown;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(AppSpacing.spacingL),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.surface,
        borderRadius: AppBorders.largeBorderRadius,
        border: Border.all(
          color:
              borderColor ?? context.colors.textPrimary.withValues(alpha: .4),
          width: AppBorders.smallBorderWidth,
        ),
      ),
      child: Row(
        spacing: AppSpacing.spacingM,
        crossAxisAlignment: .start,
        children: [
          if (icon case final iconData?)
            Container(
              padding: .all(AppSpacing.spacingM),
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? context.colors.white,
                borderRadius: AppBorders.mediumBorderRadius,
              ),
              child: Icon(iconData, size: AppSizes.iconSizeL, color: iconColor),
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
                              : buttonIcon,
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
