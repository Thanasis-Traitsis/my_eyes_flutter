import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/core/constants/app_values.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/repositories/prescription_repository.dart';
import 'package:my_eyes/presentation/prescription_history/cubit/prescription_history_cubit.dart';

class MockPrescriptionRepository extends Mock
    implements PrescriptionRepository {}

List<Prescription> _makePrescriptions(int count) {
  final base = DateTime(2024, 1, 1);
  return List.generate(
    count,
    (i) => Prescription(
      id: 'p$i',
      label: 'Rx $i',
      issueDate: base.subtract(Duration(days: i * 30)),
      rightEye: const EyeMeasurement(
        sphere: -2.0,
        cylinder: -0.5,
        axis: 180,
        addition: 0,
        pd: 62,
      ),
      leftEye: const EyeMeasurement(
        sphere: -1.75,
        cylinder: -0.25,
        axis: 170,
        addition: 0,
        pd: 62,
      ),
      updatedAt: base,
    ),
  );
}

void main() {
  late MockPrescriptionRepository repository;

  setUp(() => repository = MockPrescriptionRepository());

  PrescriptionHistoryCubit buildCubit() => PrescriptionHistoryCubit(repository);

  group('loadFirstPage', () {
    blocTest<PrescriptionHistoryCubit, PrescriptionHistoryState>(
      'emits loading then loaded with hasMore true when full page returned',
      build: () {
        when(
          () => repository.getPrescriptionsPaged(
            offset: 0,
            limit: AppValues.kPrescriptionHistoryPageSize,
          ),
        ).thenAnswer(
          (_) async =>
              _makePrescriptions(AppValues.kPrescriptionHistoryPageSize),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(),
      expect: () => [
        const PrescriptionHistoryLoading(),
        isA<PrescriptionHistoryLoaded>()
            .having(
              (s) => s.items.length,
              'items.length',
              AppValues.kPrescriptionHistoryPageSize,
            )
            .having((s) => s.hasMore, 'hasMore', true)
            .having((s) => s.isFetchingMore, 'isFetchingMore', false),
      ],
    );

    blocTest<PrescriptionHistoryCubit, PrescriptionHistoryState>(
      'hasMore is false when fewer than page size items returned',
      build: () {
        when(
          () => repository.getPrescriptionsPaged(
            offset: 0,
            limit: AppValues.kPrescriptionHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makePrescriptions(4));
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(),
      expect: () => [
        const PrescriptionHistoryLoading(),
        isA<PrescriptionHistoryLoaded>()
            .having((s) => s.hasMore, 'hasMore', false)
            .having((s) => s.items.length, 'items.length', 4),
      ],
    );

    blocTest<PrescriptionHistoryCubit, PrescriptionHistoryState>(
      'emits error when repository throws',
      build: () {
        when(
          () => repository.getPrescriptionsPaged(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(Exception('storage error'));
        return buildCubit();
      },
      act: (cubit) => cubit.loadFirstPage(),
      expect: () => [
        const PrescriptionHistoryLoading(),
        isA<PrescriptionHistoryError>(),
      ],
    );
  });

  group('loadNextPage', () {
    blocTest<PrescriptionHistoryCubit, PrescriptionHistoryState>(
      'appends next page to existing items',
      build: () {
        when(
          () => repository.getPrescriptionsPaged(
            offset: 0,
            limit: AppValues.kPrescriptionHistoryPageSize,
          ),
        ).thenAnswer(
          (_) async =>
              _makePrescriptions(AppValues.kPrescriptionHistoryPageSize),
        );
        when(
          () => repository.getPrescriptionsPaged(
            offset: AppValues.kPrescriptionHistoryPageSize,
            limit: AppValues.kPrescriptionHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makePrescriptions(3));
        return buildCubit();
      },
      act: (cubit) async {
        await cubit.loadFirstPage();
        await cubit.loadNextPage();
      },
      expect: () => [
        const PrescriptionHistoryLoading(),
        isA<PrescriptionHistoryLoaded>()
            .having(
              (s) => s.items.length,
              'items.length',
              AppValues.kPrescriptionHistoryPageSize,
            )
            .having((s) => s.hasMore, 'hasMore', true),
        isA<PrescriptionHistoryLoaded>().having(
          (s) => s.isFetchingMore,
          'isFetchingMore',
          true,
        ),
        isA<PrescriptionHistoryLoaded>()
            .having(
              (s) => s.items.length,
              'items.length',
              AppValues.kPrescriptionHistoryPageSize + 3,
            )
            .having((s) => s.hasMore, 'hasMore', false)
            .having((s) => s.isFetchingMore, 'isFetchingMore', false),
      ],
    );

    blocTest<PrescriptionHistoryCubit, PrescriptionHistoryState>(
      'does nothing when hasMore is false',
      build: () {
        when(
          () => repository.getPrescriptionsPaged(
            offset: 0,
            limit: AppValues.kPrescriptionHistoryPageSize,
          ),
        ).thenAnswer((_) async => _makePrescriptions(2));
        return buildCubit();
      },
      act: (cubit) async {
        await cubit.loadFirstPage();
        await cubit.loadNextPage();
      },
      expect: () => [
        const PrescriptionHistoryLoading(),
        isA<PrescriptionHistoryLoaded>().having(
          (s) => s.hasMore,
          'hasMore',
          false,
        ),
      ],
    );

    blocTest<PrescriptionHistoryCubit, PrescriptionHistoryState>(
      'does nothing when state is not loaded',
      build: () => buildCubit(),
      act: (cubit) => cubit.loadNextPage(),
      expect: () => [],
    );
  });
}
