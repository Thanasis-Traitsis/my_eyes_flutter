import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/enums/chart_date_filter.dart';
import 'package:my_eyes/domain/repositories/eyewear_test_repository.dart';
import 'package:my_eyes/injection.dart';
import 'package:my_eyes/presentation/eyetest/widgets/chart_diagram.dart';
import 'package:my_eyes/presentation/eyetest/widgets/filter_row.dart';
import 'package:my_eyes/presentation/eyewear/cubit/eyewear_cubit.dart';
import 'package:my_eyes/presentation/test_history/cubit/test_history_cubit.dart';

class TestStatistics extends StatelessWidget {
  const TestStatistics({super.key, this.eyewearIdFilter});

  final String? eyewearIdFilter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TestHistoryCubit(getIt<EyewearTestRepository>())..loadFirstPage(),
      child: _TestStatisticsBody(eyewearIdFilter: eyewearIdFilter),
    );
  }
}

class _TestStatisticsBody extends StatefulWidget {
  const _TestStatisticsBody({this.eyewearIdFilter});

  final String? eyewearIdFilter;

  @override
  State<_TestStatisticsBody> createState() => _TestStatisticsBodyState();
}

class _TestStatisticsBodyState extends State<_TestStatisticsBody> {
  ChartDateFilter _filter = ChartDateFilter.threeMonths;

  @override
  Widget build(BuildContext context) {
    final eyewearState = context.watch<EyewearCubit>().state;
    final testState = context.watch<TestHistoryCubit>().state;

    if (eyewearState is! EyewearLoaded || testState is! TestHistoryLoaded) {
      return const SizedBox(
        height: 180,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final allItems = eyewearState.items;
    final items = widget.eyewearIdFilter == null
        ? allItems
        : allItems.where((e) => e.id == widget.eyewearIdFilter).toList();
    final allTests = testState.items;

    if (items.isEmpty || allTests.isEmpty) {
      return const SizedBox(
        height: 180,
        child: Center(child: Text(AppStrings.eyeTestStatisticsEmpty)),
      );
    }

    final cutoff = _filter.cutoff;
    final tests = cutoff == null
        ? allTests
        : allTests.where((t) => t.takenAt.isAfter(cutoff)).toList();

    return Column(
      spacing: AppSpacing.spacingM,
      children: [
        Container(
          height: 220,
          margin: .only(top: AppSpacing.spacingL, right: AppSpacing.spacingL),
          child: tests.isEmpty
              ? Center(child: Text(AppStrings.eyeTestStatisticsEmpty))
              : ChartDiagram(items: items, tests: tests),
        ),
        FilterRow(
          selected: _filter,
          onChanged: (f) => setState(() => _filter = f),
        ),
      ],
    );
  }
}
