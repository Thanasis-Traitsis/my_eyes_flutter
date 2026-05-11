import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/domain/repositories/eyewear_repository.dart';
import 'package:my_eyes/presentation/eyewear/cubit/eyewear_cubit.dart';

class MockEyewearRepository extends Mock implements EyewearRepository {}

class FakeEyewearItem extends Fake implements EyewearItem {}

void main() {
  late MockEyewearRepository repository;

  setUpAll(() => registerFallbackValue(FakeEyewearItem()));

  final tDate = DateTime(2024, 1, 15);

  final tItem = EyewearItem(
    id: 'e1',
    name: 'Daily Frames',
    category: EyewearCategory.nearSightedGlasses,
    updatedAt: tDate,
  );

  setUp(() {
    repository = MockEyewearRepository();
  });

  EyewearCubit buildCubit() => EyewearCubit(repository);

  group('loadEyewear', () {
    blocTest<EyewearCubit, EyewearState>(
      'emits loading then loaded with items',
      build: () {
        when(() => repository.getAll()).thenAnswer((_) async => [tItem]);
        return buildCubit();
      },
      act: (cubit) => cubit.loadEyewear(),
      expect: () => [
        const EyewearLoading(),
        EyewearLoaded(items: [tItem]),
      ],
    );

    blocTest<EyewearCubit, EyewearState>(
      'emits loaded with empty list when repository is empty',
      build: () {
        when(() => repository.getAll()).thenAnswer((_) async => []);
        return buildCubit();
      },
      act: (cubit) => cubit.loadEyewear(),
      expect: () => [const EyewearLoading(), const EyewearLoaded(items: [])],
    );

    blocTest<EyewearCubit, EyewearState>(
      'emits error when repository throws',
      build: () {
        when(() => repository.getAll()).thenThrow(Exception('storage error'));
        return buildCubit();
      },
      act: (cubit) => cubit.loadEyewear(),
      expect: () => [const EyewearLoading(), isA<EyewearError>()],
    );
  });

  group('addItem', () {
    blocTest<EyewearCubit, EyewearState>(
      'saves item then reloads — emits loading then loaded',
      build: () {
        when(() => repository.save(any())).thenAnswer((_) async {});
        when(() => repository.getAll()).thenAnswer((_) async => [tItem]);
        return buildCubit();
      },
      act: (cubit) => cubit.addItem(tItem),
      expect: () => [
        const EyewearLoading(),
        EyewearLoaded(items: [tItem]),
      ],
      verify: (_) {
        verify(() => repository.save(tItem)).called(1);
        verify(() => repository.getAll()).called(1);
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'emits error when save throws',
      build: () {
        when(() => repository.save(any())).thenThrow(Exception('write error'));
        return buildCubit();
      },
      act: (cubit) => cubit.addItem(tItem),
      expect: () => [isA<EyewearError>()],
    );
  });

  group('updateItem', () {
    blocTest<EyewearCubit, EyewearState>(
      'updates item then reloads — emits loading then loaded',
      build: () {
        when(() => repository.update(any())).thenAnswer((_) async {});
        when(() => repository.getAll()).thenAnswer((_) async => [tItem]);
        return buildCubit();
      },
      act: (cubit) => cubit.updateItem(tItem),
      expect: () => [
        const EyewearLoading(),
        EyewearLoaded(items: [tItem]),
      ],
      verify: (_) {
        verify(() => repository.update(tItem)).called(1);
        verify(() => repository.getAll()).called(1);
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'emits error when update throws',
      build: () {
        when(
          () => repository.update(any()),
        ).thenThrow(Exception('write error'));
        return buildCubit();
      },
      act: (cubit) => cubit.updateItem(tItem),
      expect: () => [isA<EyewearError>()],
    );
  });

  group('deleteItem', () {
    blocTest<EyewearCubit, EyewearState>(
      'deletes item by id then reloads — emits loading then loaded with shorter list',
      build: () {
        when(() => repository.delete('e1')).thenAnswer((_) async {});
        when(() => repository.getAll()).thenAnswer((_) async => []);
        return buildCubit();
      },
      act: (cubit) => cubit.deleteItem(tItem),
      expect: () => [const EyewearLoading(), const EyewearLoaded(items: [])],
      verify: (_) {
        // Must delete by id, not by the whole object
        verify(() => repository.delete('e1')).called(1);
        verify(() => repository.getAll()).called(1);
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'emits error when delete throws',
      build: () {
        when(
          () => repository.delete(any()),
        ).thenThrow(Exception('delete error'));
        return buildCubit();
      },
      act: (cubit) => cubit.deleteItem(tItem),
      expect: () => [isA<EyewearError>()],
    );
  });
}
