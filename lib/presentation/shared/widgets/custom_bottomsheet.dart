import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_action_button.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class CustomBottomsheet extends StatelessWidget {
  const CustomBottomsheet({
    super.key,
    required this.bottomsheetTitle,
    required this.content,
    this.secondaryButtonText,
    this.primaryButtonText,
    this.primaryOnPressed,
    this.secondaryOnPressed,
    this.isPrimaryActive,
  });

  final String? secondaryButtonText;
  final String? primaryButtonText;
  final VoidCallback? primaryOnPressed;
  final VoidCallback? secondaryOnPressed;
  final bool? isPrimaryActive;
  final Widget content;
  final String bottomsheetTitle;

  bool get withButtons =>
      (secondaryButtonText != null &&
      primaryButtonText != null &&
      primaryOnPressed != null &&
      isPrimaryActive != null);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppBorders.largeBorderRadius.topLeft.x),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.spacingL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.spacingL,
            children: [
              Row(
                spacing: AppSpacing.spacingM,
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .end,
                children: [
                  CustomText(
                    text: bottomsheetTitle,
                    textType: CustomTextType.bigHeading,
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(null),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              content,
              if (withButtons)
                Row(
                  spacing: AppSpacing.spacingM,
                  children: [
                    Expanded(
                      child: CustomActionButton(
                        buttonText: secondaryButtonText!,
                        onPressed: secondaryOnPressed != null
                            ? secondaryOnPressed!
                            : () => Navigator.of(context).pop(null),
                      ),
                    ),
                    Expanded(
                      child: CustomActionButton(
                        buttonText: primaryButtonText!,
                        onPressed: primaryOnPressed!,
                        isPrimary: true,
                        isActive: isPrimaryActive!,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
