import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_values.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/domain/repositories/eyewear_test_repository.dart';
import 'package:my_eyes/injection.dart';
import 'package:my_eyes/presentation/shared/screens/full_screen_with_title.dart';
import 'package:my_eyes/presentation/test_history/cubit/test_history_cubit.dart';
import 'package:my_eyes/presentation/test_history/widgets/filter_bottomsheet.dart';
import 'package:my_eyes/presentation/test_history/widgets/filter_button.dart';
import 'package:my_eyes/presentation/test_history/widgets/test_list.dart';

class TestHistoryScreenArgs {
  const TestHistoryScreenArgs({
    required this.items,
    required this.filters,
    required this.hasMore,
  });

  final List<EyewearTest> items;
  final Set<String> filters;
  final bool hasMore;
}

class TestHistoryScreen extends StatelessWidget {
  const TestHistoryScreen({super.key, this.args});

  final TestHistoryScreenArgs? args;

  @override
  Widget build(BuildContext context) {
    final cubit = TestHistoryCubit(getIt<EyewearTestRepository>());

    if (args != null) {
      cubit.seedFirstPage(
        items: args!.items,
        filters: args!.filters,
        hasMore: args!.hasMore,
      );
    } else {
      cubit.loadFirstPage();
    }

    return BlocProvider(create: (_) => cubit, child: const _TestHistoryView());
  }
}

class _TestHistoryView extends StatefulWidget {
  const _TestHistoryView();

  @override
  State<_TestHistoryView> createState() => _TestHistoryViewState();
}

class _TestHistoryViewState extends State<_TestHistoryView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = context.read<TestHistoryCubit>().state;
    if (state is! TestHistoryLoaded || !state.hasMore || state.isFetchingMore) {
      return;
    }
    final itemHeight =
        _scrollController.position.maxScrollExtent /
        (state.items.isNotEmpty ? state.items.length : 1);
    final triggerOffset =
        _scrollController.position.maxScrollExtent -
        (itemHeight * AppValues.kTestHistoryPrefetchThreshold);

    if (_scrollController.offset >= triggerOffset) {
      context.read<TestHistoryCubit>().loadNextPage();
    }
  }

  Future<void> _openFilterSheet(
    List<EyewearItem> items,
    Set<String> activeFilters,
  ) async {
    final result = await showFilterBottomSheet(
      context: context,
      items: items,
      activeFilters: activeFilters,
    );
    if (result != null && mounted) {
      context.read<TestHistoryCubit>().loadFirstPage(filters: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FullScreenWithTitle(
      currentPage: AppPages.testHistory,
      child: BlocBuilder<TestHistoryCubit, TestHistoryState>(
        builder: (context, state) {
          final activeFilters = switch (state) {
            TestHistoryLoaded(:final filters) => filters,
            TestHistoryLoading(:final filters) => filters,
            _ => const <String>{},
          };

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.spacingM,
            children: [
              FilterSection(
                activeFilters: activeFilters,
                onTap: (eyewearState) =>
                    _openFilterSheet(eyewearState.items, activeFilters),
                onRemoveFilter: (id) {
                  final updated = Set.of(activeFilters)..remove(id);
                  context.read<TestHistoryCubit>().loadFirstPage(
                    filters: updated,
                  );
                },
              ),
              switch (state) {
                TestHistoryInitial() || TestHistoryLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                TestHistoryError(:final message) => Center(
                  child: Text(message),
                ),
                TestHistoryLoaded(:final items, :final isFetchingMore) =>
                  TestList(
                    items: items,
                    isFetchingMore: isFetchingMore,
                    scrollController: _scrollController,
                  ),
              },
            ],
          );
        },
      ),
    );
  }
}
