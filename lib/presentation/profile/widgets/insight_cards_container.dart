import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/presentation/profile/widgets/profile_insight_card.dart';

class InsightCardsContainer extends StatelessWidget {
  const InsightCardsContainer({super.key, this.withLenses = false});

  final bool withLenses;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: withLenses ? Axis.vertical : Axis.horizontal,
      spacing: AppSpacing.spacingM,
      children: [
        Expanded(
          child: ProfileInsightCard(
            title: AppStrings.profileStatTests,
            value: 14,
          ),
        ),
        Expanded(
          child: ProfileInsightCard(
            title: AppStrings.profileStatGlasses,
            value: 3,
          ),
        ),
      ],
    );
  }
}
