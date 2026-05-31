import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class LabelTag extends StatelessWidget {
  const LabelTag({super.key, required this.label, this.greenTag = false});

  final String label;
  final bool greenTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(
        vertical: AppSpacing.spacingS,
        horizontal: AppSpacing.spacingM,
      ),
      decoration: BoxDecoration(
        color: greenTag ? context.colors.tintMintDark : context.colors.tintBlue,
        borderRadius: AppBorders.smallBorderRadius,
        border: Border.all(
          color: greenTag ? context.colors.tintMint : context.colors.primary,
          width: AppBorders.smallBorderWidth,
        ),
      ),
      child: CustomText(
        text: label.toUpperCase(),
        textType: CustomTextType.extraSmallHeading,
        color: greenTag ? context.colors.white : context.colors.primary,
      ),
    );
  }
}
