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

  group('getTests — with eyewearId', () {
    test('returns entities filtered by eyewearId', () async {
      when(
        () => mockDataSource.getTests(eyewearId: 'e1'),
      ).thenAnswer((_) async => [tModel]);

      final result = await repository.getTests(eyewearId: 'e1');

      expect(result, [tEntity]);
      verify(() => mockDataSource.getTests(eyewearId: 'e1')).called(1);
    });

    test('returns empty list when datasource returns nothing', () async {
      when(
        () => mockDataSource.getTests(eyewearId: 'e1'),
      ).thenAnswer((_) async => []);

      final result = await repository.getTests(eyewearId: 'e1');

      expect(result, isEmpty);
    });

    test('maps all fields correctly', () async {
      when(
        () => mockDataSource.getTests(eyewearId: 'e1'),
      ).thenAnswer((_) async => [tModel]);

      final entity = (await repository.getTests(eyewearId: 'e1')).first;

      expect(entity.id, 't1');
      expect(entity.eyewearId, 'e1');
      expect(entity.score, 75);
      expect(entity.takenAt, tDate);
    });
  });

  group('getTests — without eyewearId (all tests)', () {
    test(
      'passes null eyewearId to datasource and returns all entities',
      () async {
        when(
          () => mockDataSource.getTests(eyewearId: null),
        ).thenAnswer((_) async => [tModel]);

        final result = await repository.getTests();

        expect(result, [tEntity]);
        verify(() => mockDataSource.getTests(eyewearId: null)).called(1);
      },
    );

    test('returns empty list when datasource returns nothing', () async {
      when(
        () => mockDataSource.getTests(eyewearId: null),
      ).thenAnswer((_) async => []);

      final result = await repository.getTests();

      expect(result, isEmpty);
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
