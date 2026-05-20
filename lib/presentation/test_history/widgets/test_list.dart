import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/test_history_card.dart';

class TestList extends StatelessWidget {
  const TestList({
    super.key,
    required this.items,
    required this.isFetchingMore,
    required this.scrollController,
  });

  final List<EyewearTest> items;
  final bool isFetchingMore;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: CustomText(text: AppStrings.eyewearTestHistoryEmpty),
      );
    }
    return Column(
      spacing: AppSpacing.spacingM,
      children: [
        for (final test in items) TestHistoryCard(test: test),
        if (isFetchingMore)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.spacingM),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
