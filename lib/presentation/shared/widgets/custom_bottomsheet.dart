import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';
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
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.spacingL,
                  AppSpacing.spacingL,
                  AppSpacing.spacingL,
                  0,
                ),
                child: Row(
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
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.spacingL),
                  child: content,
                ),
              ),
              if (withButtons)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.spacingL,
                    0,
                    AppSpacing.spacingL,
                    AppSpacing.spacingL,
                  ),
                  child: Row(
                    spacing: AppSpacing.spacingM,
                    children: [
                      Expanded(
                        child: AppButton.outlined(
                          text: secondaryButtonText!,
                          onPressed:
                              secondaryOnPressed ??
                              () => Navigator.of(context).pop(null),
                        ),
                      ),
                      Expanded(
                        child: AppButton.filled(
                          text: primaryButtonText!,
                          onPressed: isPrimaryActive!
                              ? primaryOnPressed!
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
