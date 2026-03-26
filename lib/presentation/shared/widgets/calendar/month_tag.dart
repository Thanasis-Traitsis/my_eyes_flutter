import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class MonthTag extends StatelessWidget {
  final String monthText;

  const MonthTag({super.key, required this.monthText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(
        horizontal: AppSpacing.spacingM,
        vertical: AppSpacing.spacingS,
      ),
      decoration: BoxDecoration(
        color: context.colors.textHint,
        borderRadius: AppBorders.extraSmallBorderRadius,
      ),
      child: CustomText(text: monthText),
    );
  }
}
