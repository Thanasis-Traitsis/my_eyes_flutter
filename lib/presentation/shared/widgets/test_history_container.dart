import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/presentation/eyetest/cubit/eyewear_test_cubit.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/test_history_card.dart';

class TestHistoryContainer extends StatelessWidget {
  const TestHistoryContainer({super.key, this.eyewearId});

  final String? eyewearId;

  List<EyewearTest> _filter(List<EyewearTest> all) => eyewearId == null
      ? all
      : all.where((t) => t.eyewearId == eyewearId).toList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EyewearTestCubit, EyewearTestState>(
      builder: (context, state) {
        return CustomContainer(
          icon: Icons.history,
          containerTitle: AppStrings.eyewearSectionTestHistory,
          containerChild: switch (state) {
            EyewearTestInitial() || EyewearTestLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            EyewearTestError(:final message) => Center(child: Text(message)),
            EyewearTestLoaded(:final tests) => _buildList(_filter(tests)),
          },
        );
      },
    );
  }

  Widget _buildList(List<EyewearTest> tests) {
    if (tests.isEmpty) {
      return CustomText(text: AppStrings.eyewearTestHistoryEmpty);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.spacingM,
      children: [for (final test in tests) TestHistoryCard(test: test)],
    );
  }
}
