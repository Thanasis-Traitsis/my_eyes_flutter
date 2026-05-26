import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/core/constants/app_values.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/domain/enums/test_filter_key.dart';
import 'package:my_eyes/domain/repositories/eyewear_test_repository.dart';
import 'package:my_eyes/presentation/test_history/cubit/test_history_cubit.dart';

class MockEyewearTestRepository extends Mock implements EyewearTestRepository {}

List<EyewearTest> _makeTests(int count, {String eyewearId = 'e1'}) =>
    List.generate(
      count,
      (i) => EyewearTest(
        id: 't$i',
        eyewearId: eyewearId,
        score: 80,
        takenAt: DateTime(2024, 1, i + 1),
      ),
    );

const Map<TestFilterKey, Set<String>> _noFilters = {};
const Map<TestFilterKey, Set<String>> _filterE1 = {
  TestFilterKey.eyewearId: {'e1'},
};
const Map<TestFilterKey, Set<String>> _filterE1E2 = {
  TestFilterKey.eyewearId: {'e1', 'e2'},
};

void main() {
  late MockEyewearTestRepository repository;

  setUp(() => repository = MockEyewearTestRepository());

  TestHistoryCubit buildCubit() => TestHistoryCubit(repository);

  group('loadFirstPage', () {
    blocTest<TestHistoryCubit, TestHistoryState>(
      'emits loading then loaded — no filters fetches all',
      build: () {
        when(
          () => repository.getTestsPaged(
            filters: _noFilters,
            offset: 0,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(AppValues.kTestHistoryPageSize));
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(),
      expect: () => [
        const TestHistoryLoading(filters: _noFilters),
        isA<TestHistoryLoaded>()
            .having(
              (s) => s.items.length,
              'items.length',
              AppValues.kTestHistoryPageSize,
            )
            .having((s) => s.hasMore, 'hasMore', true)
            .having((s) => s.isFetchingMore, 'isFetchingMore', false)
            .having((s) => s.filters, 'filters', _noFilters),
      ],
    );

    blocTest<TestHistoryCubit, TestHistoryState>(
      'hasMore is false when fewer than page size items are returned',
      build: () {
        when(
          () => repository.getTestsPaged(
            filters: _noFilters,
            offset: 0,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(5));
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(),
      expect: () => [
        const TestHistoryLoading(filters: _noFilters),
        isA<TestHistoryLoaded>()
            .having((s) => s.hasMore, 'hasMore', false)
            .having((s) => s.items.length, 'items.length', 5),
      ],
    );

    blocTest<TestHistoryCubit, TestHistoryState>(
      'passes single-value filter map to repository',
      build: () {
        when(
          () => repository.getTestsPaged(
            filters: _filterE1,
            offset: 0,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(3));
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(filters: _filterE1),
      expect: () => [
        const TestHistoryLoading(filters: _filterE1),
        isA<TestHistoryLoaded>()
            .having((s) => s.filters, 'filters', _filterE1)
            .having((s) => s.items.length, 'items.length', 3),
      ],
      verify: (_) => verify(
        () => repository.getTestsPaged(
          filters: _filterE1,
          offset: 0,
          limit: AppValues.kTestHistoryPageSize,
        ),
      ).called(1),
    );

    blocTest<TestHistoryCubit, TestHistoryState>(
      'passes multi-value filter map to repository',
      build: () {
        when(
          () => repository.getTestsPaged(
            filters: _filterE1E2,
            offset: 0,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(4));
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(filters: _filterE1E2),
      expect: () => [
        const TestHistoryLoading(filters: _filterE1E2),
        isA<TestHistoryLoaded>()
            .having((s) => s.filters, 'filters', _filterE1E2)
            .having((s) => s.items.length, 'items.length', 4),
      ],
      verify: (_) => verify(
        () => repository.getTestsPaged(
          filters: _filterE1E2,
          offset: 0,
          limit: AppValues.kTestHistoryPageSize,
        ),
      ).called(1),
    );

    blocTest<TestHistoryCubit, TestHistoryState>(
      'emits error when repository throws',
      build: () {
        when(
          () => repository.getTestsPaged(
            filters: any(named: 'filters'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(Exception('storage error'));
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(),
      expect: () => [
        const TestHistoryLoading(filters: _noFilters),
        isA<TestHistoryError>(),
      ],
    );
  });

  group('seedFirstPage', () {
    test('emits loaded state directly without calling repository', () {
      final cubit = buildCubit();
      final items = _makeTests(3);

      cubit.seedFirstPage(items: items, filters: _filterE1, hasMore: true);

      expect(
        cubit.state,
        isA<TestHistoryLoaded>()
            .having((s) => s.items, 'items', items)
            .having((s) => s.filters, 'filters', _filterE1)
            .having((s) => s.hasMore, 'hasMore', true)
            .having((s) => s.isFetchingMore, 'isFetchingMore', false),
      );
      verifyNever(
        () => repository.getTestsPaged(
          filters: any(named: 'filters'),
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
        ),
      );
      cubit.close();
    });
  });

  group('loadNextPage', () {
    blocTest<TestHistoryCubit, TestHistoryState>(
      'appends next page — passes same filter map as first page',
      build: () {
        when(
          () => repository.getTestsPaged(
            filters: _filterE1E2,
            offset: 0,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(AppValues.kTestHistoryPageSize));
        when(
          () => repository.getTestsPaged(
            filters: _filterE1E2,
            offset: AppValues.kTestHistoryPageSize,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(5));
        return buildCubit();
      },
      act: (cubit) async {
        await cubit.loadFirstPage(filters: _filterE1E2);
        await cubit.loadNextPage();
      },
      expect: () => [
        const TestHistoryLoading(filters: _filterE1E2),
        isA<TestHistoryLoaded>()
            .having(
              (s) => s.items.length,
              'items.length',
              AppValues.kTestHistoryPageSize,
            )
            .having((s) => s.hasMore, 'hasMore', true),
        isA<TestHistoryLoaded>().having(
          (s) => s.isFetchingMore,
          'isFetchingMore',
          true,
        ),
        isA<TestHistoryLoaded>()
            .having(
              (s) => s.items.length,
              'items.length',
              AppValues.kTestHistoryPageSize + 5,
            )
            .having((s) => s.hasMore, 'hasMore', false)
            .having((s) => s.isFetchingMore, 'isFetchingMore', false),
      ],
    );

    blocTest<TestHistoryCubit, TestHistoryState>(
      'does nothing when hasMore is false',
      build: () {
        when(
          () => repository.getTestsPaged(
            filters: _noFilters,
            offset: 0,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(3));
        return buildCubit();
      },
      act: (cubit) async {
        await cubit.loadFirstPage();
        await cubit.loadNextPage();
      },
      expect: () => [
        const TestHistoryLoading(filters: _noFilters),
        isA<TestHistoryLoaded>().having((s) => s.hasMore, 'hasMore', false),
      ],
    );

    blocTest<TestHistoryCubit, TestHistoryState>(
      'does nothing when state is not loaded',
      build: () => buildCubit(),
      act: (cubit) => cubit.loadNextPage(),
      expect: () => [],
    );
  });
}
