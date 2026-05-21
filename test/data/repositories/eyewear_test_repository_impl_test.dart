import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/data/datasources/eyewear_test_local_datasource.dart';
import 'package:my_eyes/data/models/eyewear_test_model.dart';
import 'package:my_eyes/data/repositories/eyewear_test_repository_impl.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/domain/enums/test_filter_key.dart';

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

  group('getTests — with filters', () {
    test('passes filter map to datasource and returns entities', () async {
      final filters = {
        TestFilterKey.eyewearId: {'e1'},
      };
      when(
        () => mockDataSource.getTests(filters: filters),
      ).thenAnswer((_) async => [tModel]);

      final result = await repository.getTests(filters: filters);

      expect(result, [tEntity]);
      verify(() => mockDataSource.getTests(filters: filters)).called(1);
    });

    test('passes multi-value filter map to datasource', () async {
      final filters = {
        TestFilterKey.eyewearId: {'e1', 'e2'},
      };
      when(
        () => mockDataSource.getTests(filters: filters),
      ).thenAnswer((_) async => [tModel]);

      await repository.getTests(filters: filters);

      verify(() => mockDataSource.getTests(filters: filters)).called(1);
    });
  });

  group('getTests — no filters', () {
    test('passes empty map and returns all entities', () async {
      when(
        () => mockDataSource.getTests(filters: const {}),
      ).thenAnswer((_) async => [tModel]);

      final result = await repository.getTests();

      expect(result, [tEntity]);
      verify(() => mockDataSource.getTests(filters: const {})).called(1);
    });
  });

  group('getTestsPaged — with filters', () {
    test('delegates to datasource with correct parameters', () async {
      final filters = {
        TestFilterKey.eyewearId: {'e1'},
      };
      when(
        () => mockDataSource.getTestsPaged(
          filters: filters,
          offset: 0,
          limit: 15,
        ),
      ).thenAnswer((_) async => [tModel]);

      final result = await repository.getTestsPaged(
        filters: filters,
        offset: 0,
        limit: 15,
      );

      expect(result, [tEntity]);
      verify(
        () => mockDataSource.getTestsPaged(
          filters: filters,
          offset: 0,
          limit: 15,
        ),
      ).called(1);
    });

    test('passes multi-value filter map to datasource', () async {
      final filters = {
        TestFilterKey.eyewearId: {'e1', 'e2'},
      };
      when(
        () => mockDataSource.getTestsPaged(
          filters: filters,
          offset: 0,
          limit: 15,
        ),
      ).thenAnswer((_) async => [tModel]);

      await repository.getTestsPaged(filters: filters, offset: 0, limit: 15);

      verify(
        () => mockDataSource.getTestsPaged(
          filters: filters,
          offset: 0,
          limit: 15,
        ),
      ).called(1);
    });
  });

  group('getTestsPaged — no filters', () {
    test('passes empty map when no filter', () async {
      when(
        () => mockDataSource.getTestsPaged(
          filters: const {},
          offset: 15,
          limit: 15,
        ),
      ).thenAnswer((_) async => []);

      final result = await repository.getTestsPaged(offset: 15, limit: 15);

      expect(result, isEmpty);
      verify(
        () => mockDataSource.getTestsPaged(
          filters: const {},
          offset: 15,
          limit: 15,
        ),
      ).called(1);
    });
  });

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
