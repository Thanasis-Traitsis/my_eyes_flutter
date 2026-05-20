import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/data/datasources/eyewear_test_local_datasource.dart';
import 'package:my_eyes/data/models/eyewear_test_model.dart';
import 'package:my_eyes/data/repositories/eyewear_test_repository_impl.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';

class MockEyewearTestLocalDataSource extends Mock
    implements EyewearTestLocalDataSource {}

class FakeEyewearTestModel extends Fake implements EyewearTestModel {}

void main() {
  late MockEyewearTestLocalDataSource mockDataSource;
  late EyewearTestRepositoryImpl repository;

  setUpAll(() => registerFallbackValue(FakeEyewearTestModel()));

  final tDate = DateTime(2024, 6, 1);

  final tModel = EyewearTestModel(
    id: 't1',
    eyewearId: 'e1',
    score: 75,
    takenAt: tDate,
  );
  final tEntity = EyewearTest(
    id: 't1',
    eyewearId: 'e1',
    score: 75,
    takenAt: tDate,
  );

  setUp(() {
    mockDataSource = MockEyewearTestLocalDataSource();
    repository = EyewearTestRepositoryImpl(mockDataSource);
  });

  // -------------------------------------------------------------------------
  // getTests (unpaged)
  // -------------------------------------------------------------------------

  group('getTests — single filter', () {
    test('returns entities filtered by eyewearId', () async {
      when(
        () => mockDataSource.getTests(eyewearIds: {'e1'}),
      ).thenAnswer((_) async => [tModel]);

      final result = await repository.getTests(eyewearIds: {'e1'});

      expect(result, [tEntity]);
      verify(() => mockDataSource.getTests(eyewearIds: {'e1'})).called(1);
    });

    test('returns empty list when datasource returns nothing', () async {
      when(
        () => mockDataSource.getTests(eyewearIds: {'e1'}),
      ).thenAnswer((_) async => []);

      expect(await repository.getTests(eyewearIds: {'e1'}), isEmpty);
    });
  });

  group('getTests — multiple filters', () {
    test('passes the full set to datasource', () async {
      when(
        () => mockDataSource.getTests(eyewearIds: {'e1', 'e2'}),
      ).thenAnswer((_) async => [tModel]);

      await repository.getTests(eyewearIds: {'e1', 'e2'});

      verify(() => mockDataSource.getTests(eyewearIds: {'e1', 'e2'})).called(1);
    });
  });

  group('getTests — no filter (all tests)', () {
    test('passes empty set to datasource and returns all entities', () async {
      when(
        () => mockDataSource.getTests(eyewearIds: const {}),
      ).thenAnswer((_) async => [tModel]);

      final result = await repository.getTests();

      expect(result, [tEntity]);
      verify(() => mockDataSource.getTests(eyewearIds: const {})).called(1);
    });
  });

  // -------------------------------------------------------------------------
  // getTestsPaged
  // -------------------------------------------------------------------------

  group('getTestsPaged — single filter', () {
    test('delegates to datasource with correct parameters', () async {
      when(
        () => mockDataSource.getTestsPaged(
          eyewearIds: {'e1'},
          offset: 0,
          limit: 15,
        ),
      ).thenAnswer((_) async => [tModel]);

      final result = await repository.getTestsPaged(
        eyewearIds: {'e1'},
        offset: 0,
        limit: 15,
      );

      expect(result, [tEntity]);
      verify(
        () => mockDataSource.getTestsPaged(
          eyewearIds: {'e1'},
          offset: 0,
          limit: 15,
        ),
      ).called(1);
    });
  });

  group('getTestsPaged — multiple filters', () {
    test('passes the full set to datasource', () async {
      when(
        () => mockDataSource.getTestsPaged(
          eyewearIds: {'e1', 'e2'},
          offset: 0,
          limit: 15,
        ),
      ).thenAnswer((_) async => [tModel]);

      await repository.getTestsPaged(
        eyewearIds: {'e1', 'e2'},
        offset: 0,
        limit: 15,
      );

      verify(
        () => mockDataSource.getTestsPaged(
          eyewearIds: {'e1', 'e2'},
          offset: 0,
          limit: 15,
        ),
      ).called(1);
    });
  });

  group('getTestsPaged — no filter', () {
    test('passes empty set when no filter', () async {
      when(
        () => mockDataSource.getTestsPaged(
          eyewearIds: const {},
          offset: 15,
          limit: 15,
        ),
      ).thenAnswer((_) async => []);

      final result = await repository.getTestsPaged(offset: 15, limit: 15);

      expect(result, isEmpty);
      verify(
        () => mockDataSource.getTestsPaged(
          eyewearIds: const {},
          offset: 15,
          limit: 15,
        ),
      ).called(1);
    });
  });

  // -------------------------------------------------------------------------
  // saveTest
  // -------------------------------------------------------------------------

  group('saveTest', () {
    test(
      'calls datasource save with a model derived from the entity',
      () async {
        when(() => mockDataSource.save(any())).thenAnswer((_) async {});

        await repository.saveTest(tEntity);

        final captured =
            verify(() => mockDataSource.save(captureAny())).captured.single
                as EyewearTestModel;
        expect(captured.id, tEntity.id);
        expect(captured.eyewearId, tEntity.eyewearId);
        expect(captured.score, tEntity.score);
        expect(captured.takenAt, tEntity.takenAt);
      },
    );
  });
}
