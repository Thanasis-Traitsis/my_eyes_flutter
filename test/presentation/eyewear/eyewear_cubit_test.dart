import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/data/services/notification_service.dart';
import 'package:my_eyes/domain/entities/contact_lens_supply.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/entities/reminder_spec.dart';
import 'package:my_eyes/domain/enums/app_notification_channel.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/domain/enums/lens_type.dart';
import 'package:my_eyes/domain/repositories/eyewear_repository.dart';
import 'package:my_eyes/domain/services/lens_reminder_schedule.dart';
import 'package:my_eyes/presentation/eyewear/cubit/eyewear_cubit.dart';

// ── Mocks ───────────────────────────────────────────────────────────────────

class MockEyewearRepository extends Mock implements EyewearRepository {}

class MockNotificationService extends Mock implements NotificationService {}

class MockLensReminderSchedule extends Mock implements LensReminderSchedule {}

class FakeEyewearItem extends Fake implements EyewearItem {}

// ── Fixtures ────────────────────────────────────────────────────────────────

const _glassesId = 'glasses-1';
const _lensId = 'lens-1';

final _updatedAt = DateTime(2025, 1, 15);
final _activatedAt = DateTime(2025, 3, 1, 9, 0);

final _lensBaseId = _lensId.hashCode.abs() % 100000;

EyewearItem _glasses() => EyewearItem(
  id: _glassesId,
  name: 'Reading Glasses',
  category: EyewearCategory.nearSightedGlasses,
  updatedAt: _updatedAt,
);

EyewearItem _inactiveLens({int quantity = 5}) => EyewearItem(
  id: _lensId,
  name: 'Monthly Lens',
  category: EyewearCategory.contactLenses,
  updatedAt: _updatedAt,
  contactLensSupply: ContactLensSupply(
    lensType: LensType.monthly,
    quantity: quantity,
  ),
);

EyewearItem _activeLens({int quantity = 4}) => EyewearItem(
  id: _lensId,
  name: 'Monthly Lens',
  category: EyewearCategory.contactLenses,
  updatedAt: _updatedAt,
  contactLensSupply: ContactLensSupply(
    lensType: LensType.monthly,
    quantity: quantity,
    activatedAt: _activatedAt,
  ),
);

ReminderSpec _spec({
  int id = 1,
  DateTime? fireAt,
  String title = 'Title',
  String body = 'Body',
}) => ReminderSpec(
  id: id,
  fireAt: fireAt ?? DateTime(2025, 3, 28, 9, 0),
  title: title,
  body: body,
);

// ── Tests ───────────────────────────────────────────────────────────────────

void main() {
  late MockEyewearRepository repository;
  late MockNotificationService notifications;
  late MockLensReminderSchedule lensSchedule;

  setUpAll(() {
    registerFallbackValue(FakeEyewearItem());
    registerFallbackValue(LensType.daily);
    registerFallbackValue(AppNotificationChannel.lensReminders);
    registerFallbackValue(DateTime(2025));
  });

  setUp(() {
    repository = MockEyewearRepository();
    notifications = MockNotificationService();
    lensSchedule = MockLensReminderSchedule();

    // Default stubs so methods don't throw on unspecified calls. Tests that
    // care about specific behavior override these per-test.
    when(() => repository.save(any())).thenAnswer((_) async {});
    when(() => repository.update(any())).thenAnswer((_) async {});
    when(() => repository.delete(any())).thenAnswer((_) async {});
    when(() => repository.getAll()).thenAnswer((_) async => []);

    when(
      () => notifications.scheduleReminder(
        id: any(named: 'id'),
        fireAt: any(named: 'fireAt'),
        title: any(named: 'title'),
        body: any(named: 'body'),
        channel: any(named: 'channel'),
        payload: any(named: 'payload'),
      ),
    ).thenAnswer((_) async {});
    when(() => notifications.cancel(any())).thenAnswer((_) async {});

    when(() => lensSchedule.buildFor(any())).thenReturn(const []);
    when(() => lensSchedule.idsPerLens(any())).thenReturn(0);
  });

  EyewearCubit buildCubit() =>
      EyewearCubit(repository, notifications, lensSchedule);

  // ── loadEyewear ──────────────────────────────────────────────────────────

  group('loadEyewear', () {
    blocTest<EyewearCubit, EyewearState>(
      'emits [loading, loaded] with items from the repository',
      build: () {
        when(
          () => repository.getAll(),
        ).thenAnswer((_) async => [_glasses(), _activeLens()]);
        return buildCubit();
      },
      act: (cubit) => cubit.loadEyewear(),
      expect: () => [
        const EyewearLoading(),
        EyewearLoaded(items: [_glasses(), _activeLens()]),
      ],
    );

    blocTest<EyewearCubit, EyewearState>(
      'emits [loading, error] when the repository throws',
      build: () {
        when(() => repository.getAll()).thenThrow(Exception('storage error'));
        return buildCubit();
      },
      act: (cubit) => cubit.loadEyewear(),
      expect: () => [const EyewearLoading(), isA<EyewearError>()],
    );
  });

  // ── addItem ──────────────────────────────────────────────────────────────

  group('addItem', () {
    blocTest<EyewearCubit, EyewearState>(
      'saves the item then reloads',
      build: () {
        when(() => repository.getAll()).thenAnswer((_) async => [_glasses()]);
        return buildCubit();
      },
      act: (cubit) => cubit.addItem(_glasses()),
      expect: () => [
        const EyewearLoading(),
        EyewearLoaded(items: [_glasses()]),
      ],
      verify: (_) {
        verifyInOrder([
          () => repository.save(_glasses()),
          () => repository.getAll(),
        ]);
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'emits error when save throws — no loading emitted',
      build: () {
        when(() => repository.save(any())).thenThrow(Exception('write error'));
        return buildCubit();
      },
      act: (cubit) => cubit.addItem(_glasses()),
      expect: () => [isA<EyewearError>()],
    );
  });

  // ── updateItem ───────────────────────────────────────────────────────────

  group('updateItem', () {
    blocTest<EyewearCubit, EyewearState>(
      'updates the item then reloads',
      build: () {
        when(() => repository.getAll()).thenAnswer((_) async => [_glasses()]);
        return buildCubit();
      },
      act: (cubit) => cubit.updateItem(_glasses()),
      expect: () => [
        const EyewearLoading(),
        EyewearLoaded(items: [_glasses()]),
      ],
      verify: (_) {
        verifyInOrder([
          () => repository.update(_glasses()),
          () => repository.getAll(),
        ]);
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
      act: (cubit) => cubit.updateItem(_glasses()),
      expect: () => [isA<EyewearError>()],
    );
  });

  // ── deleteItem ───────────────────────────────────────────────────────────

  group('deleteItem', () {
    blocTest<EyewearCubit, EyewearState>(
      'deletes by id and reloads',
      build: buildCubit,
      act: (cubit) => cubit.deleteItem(_glasses()),
      verify: (_) {
        verifyInOrder([
          () => repository.delete(_glassesId),
          () => repository.getAll(),
        ]);
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'does not cancel notifications for an item without a contact lens',
      build: buildCubit,
      act: (cubit) => cubit.deleteItem(_glasses()),
      verify: (_) {
        verifyNever(() => notifications.cancel(any()));
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'does not cancel notifications for an inactive contact lens',
      build: buildCubit,
      act: (cubit) => cubit.deleteItem(_inactiveLens()),
      verify: (_) {
        verifyNever(() => notifications.cancel(any()));
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'cancels each reserved notification ID when deleting an active lens',
      build: () {
        when(() => lensSchedule.idsPerLens(LensType.monthly)).thenReturn(2);
        return buildCubit();
      },
      act: (cubit) => cubit.deleteItem(_activeLens()),
      verify: (_) {
        verify(() => notifications.cancel(_lensBaseId)).called(1);
        verify(() => notifications.cancel(_lensBaseId + 1)).called(1);
        verifyNever(() => notifications.cancel(_lensBaseId + 2));
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
      act: (cubit) => cubit.deleteItem(_glasses()),
      expect: () => [isA<EyewearError>()],
    );
  });

  // ── activateLens ─────────────────────────────────────────────────────────

  group('activateLens', () {
    blocTest<EyewearCubit, EyewearState>(
      'persists item with activatedAt set and quantity decremented',
      build: buildCubit,
      act: (cubit) =>
          cubit.activateLens(_inactiveLens(), activatedAt: _activatedAt),
      verify: (_) {
        final captured =
            verify(() => repository.update(captureAny())).captured.single
                as EyewearItem;
        expect(captured.contactLensSupply!.activatedAt, _activatedAt);
        expect(captured.contactLensSupply!.quantity, 4);
        expect(captured.id, _lensId);
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'schedules each spec from lensSchedule with the correct args',
      build: () {
        final specA = _spec(
          id: 100,
          fireAt: DateTime(2025, 3, 28, 9, 0),
          title: 'A',
          body: 'body-A',
        );
        final specB = _spec(
          id: 101,
          fireAt: DateTime(2025, 3, 30, 9, 0),
          title: 'B',
          body: 'body-B',
        );
        when(() => lensSchedule.buildFor(any())).thenReturn([specA, specB]);
        return buildCubit();
      },
      act: (cubit) =>
          cubit.activateLens(_inactiveLens(), activatedAt: _activatedAt),
      verify: (_) {
        verify(
          () => notifications.scheduleReminder(
            id: 100,
            fireAt: DateTime(2025, 3, 28, 9, 0),
            title: 'A',
            body: 'body-A',
            channel: AppNotificationChannel.lensReminders,
            payload: _lensId,
          ),
        ).called(1);

        verify(
          () => notifications.scheduleReminder(
            id: 101,
            fireAt: DateTime(2025, 3, 30, 9, 0),
            title: 'B',
            body: 'body-B',
            channel: AppNotificationChannel.lensReminders,
            payload: _lensId,
          ),
        ).called(1);
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'does nothing when the item has no contact lens supply',
      build: buildCubit,
      act: (cubit) => cubit.activateLens(_glasses(), activatedAt: _activatedAt),
      expect: () => const <EyewearState>[],
      verify: (_) {
        verifyNever(() => repository.update(any()));
        verifyNever(
          () => notifications.scheduleReminder(
            id: any(named: 'id'),
            fireAt: any(named: 'fireAt'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            channel: any(named: 'channel'),
            payload: any(named: 'payload'),
          ),
        );
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'does nothing when the supply quantity is zero',
      build: buildCubit,
      act: (cubit) => cubit.activateLens(
        _inactiveLens(quantity: 0),
        activatedAt: _activatedAt,
      ),
      expect: () => const <EyewearState>[],
      verify: (_) {
        verifyNever(() => repository.update(any()));
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'activates when quantity is exactly 1 — decrements to 0',
      build: buildCubit,
      act: (cubit) => cubit.activateLens(
        _inactiveLens(quantity: 1),
        activatedAt: _activatedAt,
      ),
      verify: (_) {
        final captured =
            verify(() => repository.update(captureAny())).captured.single
                as EyewearItem;
        expect(captured.contactLensSupply!.quantity, 0);
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'emits error when the repository throws',
      build: () {
        when(
          () => repository.update(any()),
        ).thenThrow(Exception('write error'));
        return buildCubit();
      },
      act: (cubit) =>
          cubit.activateLens(_inactiveLens(), activatedAt: _activatedAt),
      expect: () => [isA<EyewearError>()],
    );
  });

  // ── deactivateLens ───────────────────────────────────────────────────────

  group('deactivateLens', () {
    blocTest<EyewearCubit, EyewearState>(
      'persists item with activatedAt cleared and quantity unchanged',
      build: () {
        when(() => lensSchedule.idsPerLens(LensType.monthly)).thenReturn(2);
        return buildCubit();
      },
      act: (cubit) => cubit.deactivateLens(_activeLens()),
      verify: (_) {
        final captured =
            verify(() => repository.update(captureAny())).captured.single
                as EyewearItem;
        expect(captured.contactLensSupply!.activatedAt, isNull);
        expect(captured.contactLensSupply!.quantity, 4);
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'cancels each reserved notification ID',
      build: () {
        when(() => lensSchedule.idsPerLens(LensType.monthly)).thenReturn(2);
        return buildCubit();
      },
      act: (cubit) => cubit.deactivateLens(_activeLens()),
      verify: (_) {
        verify(() => notifications.cancel(_lensBaseId)).called(1);
        verify(() => notifications.cancel(_lensBaseId + 1)).called(1);
        verifyNever(() => notifications.cancel(_lensBaseId + 2));
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'does nothing when the item has no contact lens supply',
      build: buildCubit,
      act: (cubit) => cubit.deactivateLens(_glasses()),
      expect: () => const <EyewearState>[],
      verify: (_) {
        verifyNever(() => repository.update(any()));
        verifyNever(() => notifications.cancel(any()));
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'emits error when the repository throws',
      build: () {
        when(
          () => repository.update(any()),
        ).thenThrow(Exception('write error'));
        when(() => lensSchedule.idsPerLens(LensType.monthly)).thenReturn(2);
        return buildCubit();
      },
      act: (cubit) => cubit.deactivateLens(_activeLens()),
      expect: () => [isA<EyewearError>()],
    );
  });

  // ── updateLensActivation ─────────────────────────────────────────────────

  group('updateLensActivation', () {
    final newActivatedAt = DateTime(2025, 2, 28, 10, 0);

    blocTest<EyewearCubit, EyewearState>(
      'persists item with the new activatedAt',
      build: () {
        when(() => lensSchedule.idsPerLens(LensType.monthly)).thenReturn(2);
        return buildCubit();
      },
      act: (cubit) => cubit.updateLensActivation(
        _activeLens(),
        activatedAt: newActivatedAt,
      ),
      verify: (_) {
        final captured =
            verify(() => repository.update(captureAny())).captured.single
                as EyewearItem;
        expect(captured.contactLensSupply!.activatedAt, newActivatedAt);
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'cancels old notifications BEFORE scheduling new ones',
      build: () {
        final newSpec = _spec(
          id: 200,
          fireAt: DateTime(2025, 3, 27, 10, 0),
          title: 'new',
          body: 'new body',
        );
        when(() => lensSchedule.idsPerLens(LensType.monthly)).thenReturn(2);
        when(() => lensSchedule.buildFor(any())).thenReturn([newSpec]);
        return buildCubit();
      },
      act: (cubit) => cubit.updateLensActivation(
        _activeLens(),
        activatedAt: newActivatedAt,
      ),
      verify: (_) {
        // Ordering matters: a stale cancel arriving after the new schedule
        // would silently delete the freshly-scheduled notification.
        verifyInOrder([
          () => notifications.cancel(_lensBaseId),
          () => notifications.cancel(_lensBaseId + 1),
          () => notifications.scheduleReminder(
            id: 200,
            fireAt: DateTime(2025, 3, 27, 10, 0),
            title: 'new',
            body: 'new body',
            channel: AppNotificationChannel.lensReminders,
            payload: _lensId,
          ),
        ]);
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'computes new schedule from the *updated* item, not the original',
      build: () {
        when(() => lensSchedule.idsPerLens(LensType.monthly)).thenReturn(2);
        return buildCubit();
      },
      act: (cubit) => cubit.updateLensActivation(
        _activeLens(),
        activatedAt: newActivatedAt,
      ),
      verify: (_) {
        final passedToBuild =
            verify(() => lensSchedule.buildFor(captureAny())).captured.single
                as EyewearItem;
        expect(passedToBuild.contactLensSupply!.activatedAt, newActivatedAt);
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'does nothing when the item has no contact lens supply',
      build: buildCubit,
      act: (cubit) =>
          cubit.updateLensActivation(_glasses(), activatedAt: newActivatedAt),
      expect: () => const <EyewearState>[],
      verify: (_) {
        verifyNever(() => repository.update(any()));
        verifyNever(() => notifications.cancel(any()));
        verifyNever(
          () => notifications.scheduleReminder(
            id: any(named: 'id'),
            fireAt: any(named: 'fireAt'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            channel: any(named: 'channel'),
            payload: any(named: 'payload'),
          ),
        );
      },
    );

    blocTest<EyewearCubit, EyewearState>(
      'emits error when the repository throws',
      build: () {
        when(
          () => repository.update(any()),
        ).thenThrow(Exception('write error'));
        when(() => lensSchedule.idsPerLens(LensType.monthly)).thenReturn(2);
        return buildCubit();
      },
      act: (cubit) => cubit.updateLensActivation(
        _activeLens(),
        activatedAt: newActivatedAt,
      ),
      expect: () => [isA<EyewearError>()],
    );
  });
}
