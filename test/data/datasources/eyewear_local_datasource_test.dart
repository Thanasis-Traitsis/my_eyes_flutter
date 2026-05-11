import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/data/datasources/eyewear_local_datasource.dart';
import 'package:my_eyes/data/models/eyewear_item_model.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';

class MockBox extends Mock implements Box<EyewearItemModel> {}

class FakeEyewearItemModel extends Fake implements EyewearItemModel {}

EyewearItemModel _makeModel({
  required String id,
  required DateTime updatedAt,
}) => EyewearItemModel(
  id: id,
  name: 'Item $id',
  categoryIndex: EyewearCategory.sunglasses.index,
  updatedAt: updatedAt,
);

void main() {
  late MockBox mockBox;
  late HiveEyewearLocalDataSource datasource;

  setUpAll(() => registerFallbackValue(FakeEyewearItemModel()));

  setUp(() {
    mockBox = MockBox();
    datasource = HiveEyewearLocalDataSource(mockBox);
  });

  group('getAll', () {
    test(
      'returns items sorted by updatedAt descending (newest first)',
      () async {
        final older = _makeModel(id: 'old', updatedAt: DateTime(2023, 1, 1));
        final newer = _makeModel(id: 'new', updatedAt: DateTime(2024, 6, 1));
        when(() => mockBox.values).thenReturn([older, newer]);

        final result = await datasource.getAll();

        expect(result.first.id, 'new');
        expect(result.last.id, 'old');
      },
    );

    test('returns empty list when box is empty', () async {
      when(() => mockBox.values).thenReturn([]);

      final result = await datasource.getAll();

      expect(result, isEmpty);
    });

    test('returns single item correctly', () async {
      final item = _makeModel(id: 'e1', updatedAt: DateTime(2024, 1, 1));
      when(() => mockBox.values).thenReturn([item]);

      final result = await datasource.getAll();

      expect(result.length, 1);
      expect(result.first.id, 'e1');
    });
  });

  group('save', () {
    test('calls box.put with model id as key', () async {
      final model = _makeModel(id: 'e1', updatedAt: DateTime(2024, 1, 1));
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await datasource.save(model);

      verify(() => mockBox.put('e1', model)).called(1);
    });
  });

  group('update', () {
    test('calls box.put with model id as key', () async {
      final model = _makeModel(id: 'e1', updatedAt: DateTime(2024, 1, 1));
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await datasource.update(model);

      verify(() => mockBox.put('e1', model)).called(1);
    });
  });

  group('delete', () {
    test('calls box.delete with the given id', () async {
      when(() => mockBox.delete('e1')).thenAnswer((_) async {});

      await datasource.delete('e1');

      verify(() => mockBox.delete('e1')).called(1);
    });
  });
}
