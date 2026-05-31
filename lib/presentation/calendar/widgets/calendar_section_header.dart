import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class CalendarSectionHeader extends StatelessWidget {
  const CalendarSectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .only(top: AppSpacing.spacingL),
      child: Row(
        spacing: AppSpacing.spacingM,
        children: [
          CustomText(text: title, textType: CustomTextType.regularHeading),
          Expanded(
            child: Divider(
              color: context.colors.textPrimary.withValues(alpha: .2),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
