import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class DateAndEvent extends StatelessWidget {
  final int date;
  final String event;

  const DateAndEvent({super.key, required this.date, required this.event});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .center,
      spacing: AppSpacing.spacingM,
      children: [
        Container(
          padding: .symmetric(
            horizontal: AppSpacing.spacingM,
            vertical: AppSpacing.spacingS,
          ),
          decoration: BoxDecoration(
            color: context.colors.white,
            borderRadius: AppBorders.smallBorderRadius,
          ),
          child: CustomText(
            text: '$date',
            textType: CustomTextType.smallHeading,
          ),
        ),
        Expanded(child: CustomText(text: event)),
      ],
    );
  }
}
