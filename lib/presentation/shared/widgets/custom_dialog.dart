import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.dialogTitle,
    this.dialogBody,
    this.dialogDescription,
    this.dialogIcon,
    required this.primaryBtnText,
    required this.primaryBtnAction,
    required this.secondaryBtnText,
    required this.secondaryBtnAction,
    this.reversedButtons = false,
  });

  final String dialogTitle;
  final String? dialogDescription;
  final Widget? dialogBody;
  final IconData? dialogIcon;
  final String primaryBtnText;
  final VoidCallback primaryBtnAction;
  final String secondaryBtnText;
  final VoidCallback secondaryBtnAction;
  final bool reversedButtons;

  Widget get _primaryButton => AppButton.filled(
    text: primaryBtnText,
    onPressed: primaryBtnAction,
    size: AppButtonSize.large,
  );

  Widget get _secondaryButton => AppButton.outlined(
    text: secondaryBtnText,
    onPressed: secondaryBtnAction,
    size: AppButtonSize.large,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: .all(AppSpacing.spacingL),
        child: Column(
          mainAxisSize: .min,
          spacing: AppSpacing.spacingXL,
          children: [
            Row(
              crossAxisAlignment: .start,
              spacing: AppSpacing.spacingM,
              children: [
                if (dialogIcon != null)
                  Container(
                    padding: .all(AppSpacing.spacingM),
                    decoration: BoxDecoration(
                      color: context.colors.textPrimary,
                      borderRadius: AppBorders.mediumBorderRadius,
                    ),
                    child: Icon(
                      dialogIcon,
                      size: AppSizes.iconSizeL,
                      color: context.colors.white,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: AppSpacing.spacingM,
                    children: [
                      CustomText(
                        text: dialogTitle.toUpperCase(),
                        textType: CustomTextType.regularHeading,
                      ),
                      if (dialogDescription case final description?)
                        CustomText(text: description),
                      if (dialogBody case final body?) body,
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.spacingM,
              children: reversedButtons
                  ? [_secondaryButton, _primaryButton]
                  : [_primaryButton, _secondaryButton],
            ),
          ],
        ),
      ),
    );
  }
}
