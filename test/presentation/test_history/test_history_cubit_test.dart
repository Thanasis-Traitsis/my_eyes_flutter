import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/core/constants/app_values.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
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

void main() {
  late MockEyewearTestRepository repository;

  setUp(() => repository = MockEyewearTestRepository());

  TestHistoryCubit buildCubit() => TestHistoryCubit(repository);

  // -------------------------------------------------------------------------
  // loadFirstPage
  // -------------------------------------------------------------------------

  group('loadFirstPage', () {
    blocTest<TestHistoryCubit, TestHistoryState>(
      'emits loading then loaded — no filters fetches all',
      build: () {
        when(
          () => repository.getTestsPaged(
            eyewearIds: const {},
            offset: 0,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(AppValues.kTestHistoryPageSize));
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(),
      expect: () => [
        const TestHistoryLoading(filters: {}),
        isA<TestHistoryLoaded>()
            .having(
              (s) => s.items.length,
              'items.length',
              AppValues.kTestHistoryPageSize,
            )
            .having((s) => s.hasMore, 'hasMore', true)
            .having((s) => s.isFetchingMore, 'isFetchingMore', false)
            .having((s) => s.filters, 'filters', <String>{}),
      ],
    );

    blocTest<TestHistoryCubit, TestHistoryState>(
      'hasMore is false when fewer than page size items are returned',
      build: () {
        when(
          () => repository.getTestsPaged(
            eyewearIds: const {},
            offset: 0,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(5));
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(),
      expect: () => [
        const TestHistoryLoading(filters: {}),
        isA<TestHistoryLoaded>()
            .having((s) => s.hasMore, 'hasMore', false)
            .having((s) => s.items.length, 'items.length', 5),
      ],
    );

    blocTest<TestHistoryCubit, TestHistoryState>(
      'passes single filter set to repository',
      build: () {
        when(
          () => repository.getTestsPaged(
            eyewearIds: {'e1'},
            offset: 0,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(3));
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(filters: {'e1'}),
      expect: () => [
        const TestHistoryLoading(filters: {'e1'}),
        isA<TestHistoryLoaded>()
            .having((s) => s.filters, 'filters', {'e1'})
            .having((s) => s.items.length, 'items.length', 3),
      ],
      verify: (_) => verify(
        () => repository.getTestsPaged(
          eyewearIds: {'e1'},
          offset: 0,
          limit: AppValues.kTestHistoryPageSize,
        ),
      ).called(1),
    );

    blocTest<TestHistoryCubit, TestHistoryState>(
      'passes multiple filter set to repository — no longer falls back to null',
      build: () {
        when(
          () => repository.getTestsPaged(
            eyewearIds: {'e1', 'e2'},
            offset: 0,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(4));
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(filters: {'e1', 'e2'}),
      expect: () => [
        const TestHistoryLoading(filters: {'e1', 'e2'}),
        isA<TestHistoryLoaded>()
            .having((s) => s.filters, 'filters', {'e1', 'e2'})
            .having((s) => s.items.length, 'items.length', 4),
      ],
      verify: (_) => verify(
        () => repository.getTestsPaged(
          eyewearIds: {'e1', 'e2'},
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
            eyewearIds: any(named: 'eyewearIds'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(Exception('storage error'));
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(),
      expect: () => [
        const TestHistoryLoading(filters: {}),
        isA<TestHistoryError>(),
      ],
    );
  });

  // -------------------------------------------------------------------------
  // loadNextPage
  // -------------------------------------------------------------------------

  group('loadNextPage', () {
    blocTest<TestHistoryCubit, TestHistoryState>(
      'appends next page — passes same filters as first page',
      build: () {
        when(
          () => repository.getTestsPaged(
            eyewearIds: {'e1', 'e2'},
            offset: 0,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(AppValues.kTestHistoryPageSize));
        when(
          () => repository.getTestsPaged(
            eyewearIds: {'e1', 'e2'},
            offset: AppValues.kTestHistoryPageSize,
            limit: AppValues.kTestHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makeTests(5));
        return buildCubit();
      },
      act: (cubit) async {
        await cubit.loadFirstPage(filters: {'e1', 'e2'});
        await cubit.loadNextPage();
      },
      expect: () => [
        const TestHistoryLoading(filters: {'e1', 'e2'}),
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
            eyewearIds: const {},
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
        const TestHistoryLoading(filters: {}),
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
