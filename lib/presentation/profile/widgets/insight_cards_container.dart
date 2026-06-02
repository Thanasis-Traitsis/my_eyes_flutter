import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/presentation/profile/widgets/profile_insight_card.dart';

class InsightCardsContainer extends StatelessWidget {
  const InsightCardsContainer({
    super.key,
    required this.testsCount,
    required this.glassesCount,
    required this.lensesCount,
    this.vertical = false,
  });

  final int testsCount;
  final int glassesCount;
  final int lensesCount;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: vertical ? Axis.vertical : Axis.horizontal,
      spacing: AppSpacing.spacingM,
      children: [
        Expanded(
          child: ProfileInsightCard(
            title: AppStrings.profileStatTests,
            value: testsCount,
          ),
        ),
        Expanded(
          child: ProfileInsightCard(
            title: AppStrings.profileStatGlasses,
            value: glassesCount,
          ),
        ),
        Expanded(
          child: ProfileInsightCard(
            title: AppStrings.profileStatLenses,
            value: lensesCount,
          ),
        ),
      ],
    );
  }
}
