import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/constants/app_values.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/domain/enums/test_filter_key.dart';
import 'package:my_eyes/domain/repositories/eyewear_test_repository.dart';
import 'package:my_eyes/injection.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/test_history_card.dart';
import 'package:my_eyes/presentation/test_history/cubit/test_history_cubit.dart';
import 'package:my_eyes/presentation/test_history/screens/test_history_screen.dart';

class TestHistoryContainer extends StatelessWidget {
  const TestHistoryContainer({super.key, this.eyewearId});

  final String? eyewearId;

  static const int _cap = AppValues.testHistoryContainerMaxTest;

  Map<TestFilterKey, Set<String>> get _initialFilters => eyewearId != null
      ? {
          TestFilterKey.eyewearId: {eyewearId!},
        }
      : const {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TestHistoryCubit(getIt<EyewearTestRepository>())
            ..loadFirstPage(filters: _initialFilters),
      child: _TestHistoryContainerBody(cap: _cap),
    );
  }
}

class _TestHistoryContainerBody extends StatelessWidget {
  const _TestHistoryContainerBody({required this.cap});

  final int cap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestHistoryCubit, TestHistoryState>(
      builder: (context, state) {
        final items = switch (state) {
          TestHistoryLoaded(:final items) => items,
          _ => null,
        };

        final hasMore = (items?.length ?? 0) > cap;

        return CustomContainer(
          icon: Icons.history,
          containerTitle: AppStrings.eyewearSectionTestHistory,
          buttonText: hasMore ? AppStrings.homeButtonViewAll : null,
          onButtonPressed: hasMore
              ? () {
                  final loaded =
                      context.read<TestHistoryCubit>().state
                          as TestHistoryLoaded;
                  NavigationService.pushNamed(
                    AppPages.testHistory.name,
                    extra: TestHistoryScreenArgs(
                      items: loaded.items,
                      filters: loaded.filters,
                      hasMore: loaded.hasMore,
                    ),
                  );
                }
              : null,
          containerChild: switch (state) {
            TestHistoryInitial() || TestHistoryLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            TestHistoryError(:final message) => Center(child: Text(message)),
            TestHistoryLoaded() => Container(
              margin: const EdgeInsets.only(top: AppSpacing.spacingM),
              child: _buildList(items!),
            ),
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
      children: [
        for (final test in tests.take(cap)) TestHistoryCard(test: test),
      ],
    );
  }
}
