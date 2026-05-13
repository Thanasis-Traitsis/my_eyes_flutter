import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/data/datasources/eyewear_test_local_datasource.dart';
import 'package:my_eyes/data/models/eyewear_test_model.dart';

class MockBox extends Mock implements Box<EyewearTestModel> {}

class FakeEyewearTestModel extends Fake implements EyewearTestModel {}

EyewearTestModel _makeModel({
  required String id,
  required String eyewearId,
  required DateTime takenAt,
  int score = 80,
}) => EyewearTestModel(
  id: id,
  eyewearId: eyewearId,
  score: score,
  takenAt: takenAt,
);

void main() {
  late MockBox mockBox;
  late HiveEyewearTestLocalDataSource datasource;

  setUpAll(() => registerFallbackValue(FakeEyewearTestModel()));

  setUp(() {
    mockBox = MockBox();
    datasource = HiveEyewearTestLocalDataSource(mockBox);
  });

  group('getTests — with eyewearId', () {
    test('returns only tests matching the given eyewearId', () async {
      final match1 = _makeModel(
        id: 't1',
        eyewearId: 'e1',
        takenAt: DateTime(2024, 1, 1),
      );
      final match2 = _makeModel(
        id: 't2',
        eyewearId: 'e1',
        takenAt: DateTime(2024, 6, 1),
      );
      final other = _makeModel(
        id: 't3',
        eyewearId: 'e2',
        takenAt: DateTime(2024, 3, 1),
      );
      when(() => mockBox.values).thenReturn([match1, match2, other]);

      final result = await datasource.getTests(eyewearId: 'e1');

      expect(result.map((m) => m.id), containsAll(['t1', 't2']));
      expect(result.any((m) => m.id == 't3'), isFalse);
    });

    test('returns tests sorted by takenAt descending', () async {
      final older = _makeModel(
        id: 't-old',
        eyewearId: 'e1',
        takenAt: DateTime(2023, 1, 1),
      );
      final newer = _makeModel(
        id: 't-new',
        eyewearId: 'e1',
        takenAt: DateTime(2024, 6, 1),
      );
      when(() => mockBox.values).thenReturn([older, newer]);

      final result = await datasource.getTests(eyewearId: 'e1');

      expect(result.first.id, 't-new');
      expect(result.last.id, 't-old');
    });

    test('returns empty list when no tests match the eyewearId', () async {
      final other = _makeModel(
        id: 't1',
        eyewearId: 'e2',
        takenAt: DateTime(2024, 1, 1),
      );
      when(() => mockBox.values).thenReturn([other]);

      final result = await datasource.getTests(eyewearId: 'e1');

      expect(result, isEmpty);
    });
  });

  group('getTests — without eyewearId (all tests)', () {
    test('returns all tests when eyewearId is null', () async {
      final t1 = _makeModel(
        id: 't1',
        eyewearId: 'e1',
        takenAt: DateTime(2024, 1, 1),
      );
      final t2 = _makeModel(
        id: 't2',
        eyewearId: 'e2',
        takenAt: DateTime(2024, 6, 1),
      );
      when(() => mockBox.values).thenReturn([t1, t2]);

      final result = await datasource.getTests();

      expect(result.map((m) => m.id), containsAll(['t1', 't2']));
    });

    test('returns all tests sorted by takenAt descending', () async {
      final older = _makeModel(
        id: 't-old',
        eyewearId: 'e1',
        takenAt: DateTime(2023, 1, 1),
      );
      final newer = _makeModel(
        id: 't-new',
        eyewearId: 'e2',
        takenAt: DateTime(2024, 6, 1),
      );
      when(() => mockBox.values).thenReturn([older, newer]);

      final result = await datasource.getTests();

      expect(result.first.id, 't-new');
      expect(result.last.id, 't-old');
    });

    test('returns empty list when box is empty', () async {
      when(() => mockBox.values).thenReturn([]);

      final result = await datasource.getTests();

      expect(result, isEmpty);
    });
  });

  group('save', () {
    test('calls box.put with model id as key', () async {
      final model = _makeModel(
        id: 't1',
        eyewearId: 'e1',
        takenAt: DateTime(2024, 1, 1),
      );
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await datasource.save(model);

      verify(() => mockBox.put('t1', model)).called(1);
    });
  });
}
