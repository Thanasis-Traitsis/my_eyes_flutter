import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/data/datasources/prescription_local_datasource.dart';
import 'package:my_eyes/data/models/eye_measurement_model.dart';
import 'package:my_eyes/data/models/prescription_model.dart';
import 'package:my_eyes/data/repositories/prescription_repository_impl.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/prescription.dart';

class MockPrescriptionLocalDataSource extends Mock
    implements PrescriptionLocalDataSource {}

class FakePrescriptionModel extends Fake implements PrescriptionModel {}

void main() {
  late MockPrescriptionLocalDataSource mockDataSource;
  late PrescriptionRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(FakePrescriptionModel());
  });

  final tDate = DateTime(2024, 1, 15);

  final tModel = PrescriptionModel(
    id: 'p1',
    label: 'Test',
    issueDate: tDate,
    rightEye: EyeMeasurementModel(
      sphere: -2.5,
      cylinder: -0.75,
      axis: 180,
      addition: 0.0,
      pd: 62.0,
    ),
    leftEye: EyeMeasurementModel(
      sphere: -2.25,
      cylinder: -0.5,
      axis: 170,
      addition: 0.0,
      pd: 62.0,
    ),
    updatedAt: tDate,
  );

  final tEntity = Prescription(
    id: 'p1',
    label: 'Test',
    issueDate: tDate,
    rightEye: const EyeMeasurement(
      sphere: -2.5,
      cylinder: -0.75,
      axis: 180,
      addition: 0.0,
      pd: 62.0,
    ),
    leftEye: const EyeMeasurement(
      sphere: -2.25,
      cylinder: -0.5,
      axis: 170,
      addition: 0.0,
      pd: 62.0,
    ),
    updatedAt: tDate,
  );

  setUp(() {
    mockDataSource = MockPrescriptionLocalDataSource();
    repository = PrescriptionRepositoryImpl(mockDataSource);
  });

  group('getPrescriptions', () {
    test('returns list of entities from datasource', () async {
      when(() => mockDataSource.getAll()).thenAnswer((_) async => [tModel]);

      final result = await repository.getPrescriptions();

      expect(result, [tEntity]);
      verify(() => mockDataSource.getAll()).called(1);
    });

    test('returns empty list when datasource is empty', () async {
      when(() => mockDataSource.getAll()).thenAnswer((_) async => []);

      final result = await repository.getPrescriptions();

      expect(result, isEmpty);
    });
  });

  group('savePrescription', () {
    test('calls datasource save with correct model', () async {
      when(() => mockDataSource.save(any())).thenAnswer((_) async {});

      await repository.savePrescription(tEntity);

      verify(() => mockDataSource.save(any())).called(1);
    });
  });

  group('updatePrescription', () {
    test('calls datasource update with correct model', () async {
      when(() => mockDataSource.update(any())).thenAnswer((_) async {});

      await repository.updatePrescription(tEntity);

      verify(() => mockDataSource.update(any())).called(1);
    });
  });

  group('deletePrescription', () {
    test('calls datasource delete with correct id', () async {
      when(() => mockDataSource.delete('p1')).thenAnswer((_) async {});

      await repository.deletePrescription('p1');

      verify(() => mockDataSource.delete('p1')).called(1);
    });
  });
}
