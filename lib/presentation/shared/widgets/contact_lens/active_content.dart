import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/contact_lens_supply.dart';
import 'package:my_eyes/domain/enums/lens_type.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class ActiveContent extends StatelessWidget {
  const ActiveContent({
    super.key,
    required this.supply,
    this.isEditing = false,
    this.onUpdate,
    this.onRemove,
  });

  final ContactLensSupply supply;
  final bool isEditing;
  final VoidCallback? onUpdate;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final days = supply.daysRemaining ?? 0;
    final contentColor = context.colors.white;

    return Column(
      crossAxisAlignment: .start,
      mainAxisAlignment: .spaceBetween,
      spacing: AppSpacing.spacingM,
      children: [
        Column(
          crossAxisAlignment: .start,
          spacing: AppSpacing.spacingM,
          children: [
            if (!isEditing)
              CustomText(
                text: AppStrings.contactLensType(supply.lensType.label),
                color: contentColor,
              ),
            if (!isEditing)
              CustomText(
                text: AppStrings.contactLensSupplyQuantity(supply.quantity),
                color: contentColor,
              ),
          ],
        ),
        Column(
          crossAxisAlignment: .start,
          spacing: AppSpacing.spacingM,
          children: [
            Container(
              padding: const .symmetric(
                vertical: AppSpacing.spacingM,
                horizontal: AppSpacing.spacingL,
              ),
              decoration: BoxDecoration(
                color: contentColor.withValues(alpha: 0.15),
                borderRadius: AppBorders.mediumBorderRadius,
                border: Border.all(
                  width: AppBorders.smallBorderWidth,
                  color: contentColor,
                ),
              ),
              child: Row(
                spacing: AppSpacing.spacingM,
                crossAxisAlignment: CrossAxisAlignment.end,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Center(
                    child: CustomText(
                      text: '$days',
                      textType: CustomTextType.bigHeading,
                      color: contentColor,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const .only(bottom: AppSpacing.spacingXS),
                      child: CustomText(
                        text: AppStrings.eyewearLensStatusDaysRemaining
                            .toUpperCase(),
                        textType: CustomTextType.smallHeading,
                        color: contentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        isEditing
            ? Row(
                spacing: AppSpacing.spacingM,
                children: [
                  AppButton.outlined(
                    icon: Icons.edit,
                    text: AppStrings.contactLensButtonUpdate,
                    onPressed: onUpdate,
                  ),
                  AppButton.textButton(
                    icon: Icons.delete,
                    text: AppStrings.contactLensButtonRemove,
                    onPressed: onRemove,
                    isError: true,
                  ),
                ],
              )
            : AppButton.textButton(
                icon: Icons.delete,
                text: AppStrings.contactLensButtonRemove,
                onPressed: onRemove,
                isError: true,
              ),
      ],
    );
  }
}
