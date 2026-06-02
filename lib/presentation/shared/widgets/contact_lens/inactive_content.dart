import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/contact_lens_supply.dart';
import 'package:my_eyes/domain/enums/lens_type.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class InactiveContent extends StatelessWidget {
  const InactiveContent({
    super.key,
    required this.supply,
    required this.onActivate,
  });

  final ContactLensSupply supply;
  final VoidCallback onActivate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.spacingM,
      children: [
        CustomText(
          text: AppStrings.contactLensType(supply.lensType.label),
          color: context.colors.white,
        ),
        CustomText(
          text: AppStrings.contactLensSupplyQuantity(supply.quantity),
          color: context.colors.white,
        ),
        AppButton.filled(
          text: AppStrings.eyewearLensStatusActivateButton,
          onPressed: supply.quantity > 0 ? onActivate : null,
          size: AppButtonSize.regular,
        ),
      ],
    );
  }
}
