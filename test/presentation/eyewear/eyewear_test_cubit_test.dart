import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/domain/repositories/eyewear_test_repository.dart';
import 'package:my_eyes/presentation/eyetest/cubit/eyewear_test_cubit.dart';

class MockEyewearTestRepository extends Mock implements EyewearTestRepository {}

void main() {
  late MockEyewearTestRepository repository;

  final tDate = DateTime(2024, 6, 1);

  final tTestE1 = EyewearTest(
    id: 't1',
    eyewearId: 'e1',
    score: 75,
    takenAt: tDate,
  );

  final tTestE2 = EyewearTest(
    id: 't2',
    eyewearId: 'e2',
    score: 90,
    takenAt: tDate,
  );

  setUp(() => repository = MockEyewearTestRepository());

  EyewearTestCubit buildCubit() => EyewearTestCubit(repository);

  group('loadTests', () {
    blocTest<EyewearTestCubit, EyewearTestState>(
      'emits loading then loaded with the full unfiltered list',
      build: () {
        when(
          () => repository.getTests(),
        ).thenAnswer((_) async => [tTestE1, tTestE2]);
        return buildCubit();
      },
      act: (cubit) => cubit.loadTests(),
      expect: () => [
        const EyewearTestLoading(),
        EyewearTestLoaded(tests: [tTestE1, tTestE2]),
      ],
      verify: (_) => verify(() => repository.getTests()).called(1),
    );

    blocTest<EyewearTestCubit, EyewearTestState>(
      'emits loaded with empty list when no tests exist',
      build: () {
        when(() => repository.getTests()).thenAnswer((_) async => []);
        return buildCubit();
      },
      act: (cubit) => cubit.loadTests(),
      expect: () => [
        const EyewearTestLoading(),
        const EyewearTestLoaded(tests: []),
      ],
    );

    blocTest<EyewearTestCubit, EyewearTestState>(
      'emits error when repository throws',
      build: () {
        when(() => repository.getTests()).thenThrow(Exception('storage error'));
        return buildCubit();
      },
      act: (cubit) => cubit.loadTests(),
      expect: () => [const EyewearTestLoading(), isA<EyewearTestError>()],
    );

    blocTest<EyewearTestCubit, EyewearTestState>(
      'reloads correctly when called a second time',
      build: () {
        when(
          () => repository.getTests(),
        ).thenAnswer((_) async => [tTestE1, tTestE2]);
        return buildCubit();
      },
      act: (cubit) async {
        await cubit.loadTests();
        await cubit.loadTests();
      },
      expect: () => [
        const EyewearTestLoading(),
        EyewearTestLoaded(tests: [tTestE1, tTestE2]),
        const EyewearTestLoading(),
        EyewearTestLoaded(tests: [tTestE1, tTestE2]),
      ],
      verify: (_) => verify(() => repository.getTests()).called(2),
    );
  });
}
