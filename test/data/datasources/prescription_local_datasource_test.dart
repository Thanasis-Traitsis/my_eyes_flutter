import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive_ce/hive.dart';
import 'package:my_eyes/data/datasources/prescription_local_datasource.dart';
import 'package:my_eyes/data/models/eye_measurement_model.dart';
import 'package:my_eyes/data/models/prescription_model.dart';

class MockBox extends Mock implements Box<PrescriptionModel> {}

class FakePrescriptionModel extends Fake implements PrescriptionModel {}

void main() {
  late MockBox mockBox;
  late HivePrescriptionLocalDataSource datasource;

  setUpAll(() {
    registerFallbackValue(FakePrescriptionModel());
  });

  final tEye = EyeMeasurementModel(
    sphere: -2.5,
    cylinder: -0.75,
    axis: 180,
    addition: 0.0,
    pd: 62.0,
  );

  final tOlderModel = PrescriptionModel(
    id: 'p-old',
    label: 'Older',
    issueDate: DateTime(2023, 1, 1),
    rightEye: tEye,
    leftEye: tEye,
    updatedAt: DateTime(2023, 1, 1),
  );

  final tNewerModel = PrescriptionModel(
    id: 'p-new',
    label: 'Newer',
    issueDate: DateTime(2024, 6, 1),
    rightEye: tEye,
    leftEye: tEye,
    updatedAt: DateTime(2024, 6, 1),
  );

  setUp(() {
    mockBox = MockBox();
    datasource = HivePrescriptionLocalDataSource(mockBox);
  });

  group('getAll', () {
    test(
      'returns prescriptions sorted by issueDate descending (newest first)',
      () async {
        // Box returns them in insertion order (oldest first)
        when(() => mockBox.values).thenReturn([tOlderModel, tNewerModel]);

        final result = await datasource.getAll();

        expect(result.first.id, 'p-new');
        expect(result.last.id, 'p-old');
      },
    );

    test('returns empty list when box is empty', () async {
      when(() => mockBox.values).thenReturn([]);

      final result = await datasource.getAll();

      expect(result, isEmpty);
    });

    test('returns single item list correctly', () async {
      when(() => mockBox.values).thenReturn([tNewerModel]);

      final result = await datasource.getAll();

      expect(result.length, 1);
      expect(result.first.id, 'p-new');
    });
  });

  group('save', () {
    test('calls box.put with model id as key', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await datasource.save(tNewerModel);

      verify(() => mockBox.put(tNewerModel.id, tNewerModel)).called(1);
    });
  });

  group('update', () {
    test('calls box.put with model id as key', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await datasource.update(tNewerModel);

      verify(() => mockBox.put(tNewerModel.id, tNewerModel)).called(1);
    });
  });

  group('delete', () {
    test('calls box.delete with the given id', () async {
      when(() => mockBox.delete('p-new')).thenAnswer((_) async {});

      await datasource.delete('p-new');

      verify(() => mockBox.delete('p-new')).called(1);
    });
  });
}
