import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_eyes/core/constants/app_values.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/domain/enums/test_filter_key.dart';
import 'package:my_eyes/domain/repositories/eyewear_test_repository.dart';

part 'test_history_state.dart';

class TestHistoryCubit extends Cubit<TestHistoryState> {
  TestHistoryCubit(this._repository) : super(const TestHistoryInitial());

  final EyewearTestRepository _repository;

  Future<void> loadFirstPage({
    Map<TestFilterKey, Set<String>> filters = const {},
  }) async {
    emit(TestHistoryLoading(filters: filters));
    try {
      final items = await _repository.getTestsPaged(
        filters: filters,
        offset: 0,
        limit: AppValues.kTestHistoryPageSize,
      );
      final hasMore = items.length == AppValues.kTestHistoryPageSize;
      emit(
        TestHistoryLoaded(
          items: items,
          filters: filters,
          hasMore: hasMore,
          isFetchingMore: false,
        ),
      );
    } catch (e) {
      emit(TestHistoryError(e.toString()));
    }
  }

  void seedFirstPage({
    required List<EyewearTest> items,
    required Map<TestFilterKey, Set<String>> filters,
    required bool hasMore,
  }) {
    emit(
      TestHistoryLoaded(
        items: items,
        filters: filters,
        hasMore: hasMore,
        isFetchingMore: false,
      ),
    );
  }

  Future<void> loadNextPage() async {
    final current = state;
    if (current is! TestHistoryLoaded) return;
    if (!current.hasMore || current.isFetchingMore) return;

    emit(current.copyWith(isFetchingMore: true));
    try {
      final newItems = await _repository.getTestsPaged(
        filters: current.filters,
        offset: current.items.length,
        limit: AppValues.kTestHistoryPageSize,
      );
      final hasMore = newItems.length == AppValues.kTestHistoryPageSize;
      emit(
        current.copyWith(
          items: [...current.items, ...newItems],
          hasMore: hasMore,
          isFetchingMore: false,
        ),
      );
    } catch (e) {
      emit(current.copyWith(isFetchingMore: false));
    }
  }
}
