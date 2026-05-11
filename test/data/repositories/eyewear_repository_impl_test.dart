import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/data/datasources/eyewear_local_datasource.dart';
import 'package:my_eyes/data/models/eyewear_item_model.dart';
import 'package:my_eyes/data/repositories/eyewear_repository_impl.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';

class MockEyewearLocalDataSource extends Mock
    implements EyewearLocalDataSource {}

class FakeEyewearItemModel extends Fake implements EyewearItemModel {}

void main() {
  late MockEyewearLocalDataSource mockDataSource;
  late EyewearRepositoryImpl repository;

  setUpAll(() => registerFallbackValue(FakeEyewearItemModel()));

  final tDate = DateTime(2024, 1, 15);

  final tModel = EyewearItemModel(
    id: 'e1',
    name: 'Daily Frames',
    categoryIndex: EyewearCategory.nearSightedGlasses.index,
    updatedAt: tDate,
    selectedOptionIndex: 1,
  );

  final tEntity = EyewearItem(
    id: 'e1',
    name: 'Daily Frames',
    category: EyewearCategory.nearSightedGlasses,
    updatedAt: tDate,
    selectedOptionIndex: 1,
  );

  setUp(() {
    mockDataSource = MockEyewearLocalDataSource();
    repository = EyewearRepositoryImpl(mockDataSource);
  });

  group('getAll', () {
    test('returns list of entities from datasource', () async {
      when(() => mockDataSource.getAll()).thenAnswer((_) async => [tModel]);

      final result = await repository.getAll();

      expect(result, [tEntity]);
      verify(() => mockDataSource.getAll()).called(1);
    });

    test('returns empty list when datasource is empty', () async {
      when(() => mockDataSource.getAll()).thenAnswer((_) async => []);

      final result = await repository.getAll();

      expect(result, isEmpty);
    });
  });

  group('save', () {
    test(
      'calls datasource save with a model derived from the entity',
      () async {
        when(() => mockDataSource.save(any())).thenAnswer((_) async {});

        await repository.save(tEntity);

        final captured =
            verify(() => mockDataSource.save(captureAny())).captured.single
                as EyewearItemModel;
        expect(captured.id, tEntity.id);
        expect(captured.name, tEntity.name);
        expect(captured.categoryIndex, tEntity.category.index);
        expect(captured.selectedOptionIndex, tEntity.selectedOptionIndex);
        expect(captured.pendingSync, isTrue);
      },
    );
  });

  group('update', () {
    test(
      'calls datasource update with a model derived from the entity',
      () async {
        when(() => mockDataSource.update(any())).thenAnswer((_) async {});

        await repository.update(tEntity);

        final captured =
            verify(() => mockDataSource.update(captureAny())).captured.single
                as EyewearItemModel;
        expect(captured.id, tEntity.id);
        expect(captured.name, tEntity.name);
      },
    );
  });

  group('delete', () {
    test('calls datasource delete with the given id', () async {
      when(() => mockDataSource.delete('e1')).thenAnswer((_) async {});

      await repository.delete('e1');

      verify(() => mockDataSource.delete('e1')).called(1);
    });
  });
}
