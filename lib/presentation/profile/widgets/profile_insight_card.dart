import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class ProfileInsightCard extends StatelessWidget {
  const ProfileInsightCard({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: .all(AppSpacing.spacingM),
      decoration: BoxDecoration(
        borderRadius: AppBorders.mediumBorderRadius,
        color: context.colors.textHint,
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .end,
        children: [
          CustomText(text: "$value", textType: CustomTextType.bigHeading),
          CustomText(
            text: title.toUpperCase(),
            textType: CustomTextType.smallHeading,
          ),
        ],
      ),
    );
  }
}
