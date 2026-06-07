import 'package:flutter_test/flutter_test.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/contact_lens_supply.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/entities/reminder_spec.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/domain/enums/lens_type.dart';
import 'package:my_eyes/domain/services/lens_reminder_schedule.dart';

EyewearItem lensItem({required LensType type, DateTime? activatedAt}) {
  return EyewearItem(
    id: 'lens-1',
    name: 'My Lens',
    category: EyewearCategory.contactLenses,
    updatedAt: DateTime(2025, 1, 1),
    contactLensSupply: ContactLensSupply(
      lensType: type,
      quantity: 6,
      activatedAt: activatedAt,
    ),
  );
}

final int baseId = 'lens-1'.hashCode.abs() % 100000;

void main() {
  late LensReminderSchedule schedule;

  setUp(() => schedule = const LensReminderSchedule());

  group('buildFor — guard cases', () {
    test('returns empty list when item has no contactLensSupply', () {
      final item = EyewearItem(
        id: 'g1',
        name: 'Glasses',
        category: EyewearCategory.nearSightedGlasses,
        updatedAt: DateTime(2025, 1, 1),
      );
      expect(schedule.buildFor(item), isEmpty);
    });

    test('returns empty list when supply exists but activatedAt is null', () {
      final item = lensItem(type: LensType.monthly);
      expect(schedule.buildFor(item), isEmpty);
    });

    test('filters out specs whose fireAt is already in the past', () {
      final item = lensItem(
        type: LensType.monthly,
        activatedAt: DateTime(2025, 1, 1, 9, 0),
      );
      final result = schedule.buildFor(item, now: DateTime(2025, 2, 1));
      expect(result, isEmpty);
    });

    test('only returns specs still in the future when partially past', () {
      final activatedAt = DateTime(2025, 1, 1, 9, 0);
      final item = lensItem(type: LensType.monthly, activatedAt: activatedAt);
      final result = schedule.buildFor(item, now: DateTime(2025, 1, 29, 9, 0));
      expect(result, hasLength(1));
      expect(result.first.fireAt, activatedAt.add(const Duration(days: 29)));
    });
  });

  group('buildFor — daily lens (1 day)', () {
    test('produces exactly 1 spec', () {
      final activatedAt = DateTime(2025, 6, 1, 8, 0);
      final item = lensItem(type: LensType.daily, activatedAt: activatedAt);
      final specs = schedule.buildFor(item, now: DateTime(2025, 6, 1, 19, 59));
      expect(specs, hasLength(1));
    });

    test(
      'fires at 20:00 on the activation day when activated before 20:00',
      () {
        final activatedAt = DateTime(2025, 6, 1, 8, 0);
        final item = lensItem(type: LensType.daily, activatedAt: activatedAt);
        final specs = schedule.buildFor(item, now: activatedAt);
        expect(specs.first.fireAt, DateTime(2025, 6, 1, 20, 0));
      },
    );

    test('fires at 20:00 next day when activated after 20:00', () {
      final activatedAt = DateTime(2025, 6, 1, 21, 0);
      final item = lensItem(type: LensType.daily, activatedAt: activatedAt);
      final specs = schedule.buildFor(item, now: activatedAt);
      expect(specs.first.fireAt, DateTime(2025, 6, 2, 20, 0));
    });

    test('fires at 20:00 next day when activated exactly at 20:00', () {
      final activatedAt = DateTime(2025, 6, 1, 20, 0);
      final item = lensItem(type: LensType.daily, activatedAt: activatedAt);
      final specs = schedule.buildFor(item, now: activatedAt);
      expect(specs.first.fireAt, DateTime(2025, 6, 2, 20, 0));
    });

    test('uses base id for the single slot', () {
      final activatedAt = DateTime(2025, 6, 1, 8, 0);
      final item = lensItem(type: LensType.daily, activatedAt: activatedAt);
      final specs = schedule.buildFor(item, now: activatedAt);
      expect(specs.first.id, baseId);
    });

    test('carries the correct title and body text', () {
      final activatedAt = DateTime(2025, 6, 1, 8, 0);
      final item = lensItem(type: LensType.daily, activatedAt: activatedAt);
      final specs = schedule.buildFor(item, now: activatedAt);
      expect(specs.first.title, AppStrings.notifLensDailyTitle);
      expect(specs.first.body, AppStrings.notifLensDailyBody('My Lens'));
    });
  });

  group('buildFor — bi-weekly lens (14 days)', () {
    final activatedAt = DateTime(2025, 6, 1, 9, 0);

    late List<ReminderSpec> specs;

    setUp(() {
      final item = lensItem(type: LensType.biWeekly, activatedAt: activatedAt);
      specs = schedule.buildFor(item, now: activatedAt);
    });

    test('produces exactly 2 specs', () => expect(specs, hasLength(2)));

    test('first spec fires 3 days before expiry — offset day 11', () {
      expect(specs[0].fireAt, activatedAt.add(const Duration(days: 11)));
    });

    test('second spec fires 1 day before expiry — offset day 13', () {
      expect(specs[1].fireAt, activatedAt.add(const Duration(days: 13)));
    });

    test('IDs are base and base+1', () {
      expect(specs[0].id, baseId);
      expect(specs[1].id, baseId + 1);
    });

    test('first spec has 3-day warning text', () {
      expect(specs[0].title, AppStrings.notifLensExpiryTitle(3));
      expect(specs[0].body, AppStrings.notifLensExpiryBody('My Lens', 3));
    });

    test('second spec has tomorrow-warning text', () {
      expect(specs[1].title, AppStrings.notifLensExpiryTomorrowTitle);
      expect(specs[1].body, AppStrings.notifLensExpiryTomorrowBody('My Lens'));
    });
  });

  group('buildFor — monthly lens (30 days)', () {
    final activatedAt = DateTime(2025, 6, 1, 9, 0);

    late List<ReminderSpec> specs;

    setUp(() {
      final item = lensItem(type: LensType.monthly, activatedAt: activatedAt);
      specs = schedule.buildFor(item, now: activatedAt);
    });

    test('produces exactly 2 specs', () => expect(specs, hasLength(2)));

    test('first spec fires 3 days before expiry — offset day 27', () {
      expect(specs[0].fireAt, activatedAt.add(const Duration(days: 27)));
    });

    test('second spec fires 1 day before expiry — offset day 29', () {
      expect(specs[1].fireAt, activatedAt.add(const Duration(days: 29)));
    });

    test('IDs are base and base+1', () {
      expect(specs[0].id, baseId);
      expect(specs[1].id, baseId + 1);
    });

    test('preserves time-of-day from activatedAt across month boundary', () {
      final at = DateTime(2025, 6, 5, 14, 30);
      final item = lensItem(type: LensType.monthly, activatedAt: at);
      final result = schedule.buildFor(item, now: at);
      expect(result.first.fireAt.hour, 14);
      expect(result.first.fireAt.minute, 30);
    });
  });

  group('buildFor — quarterly lens (90 days)', () {
    final activatedAt = DateTime(2025, 1, 1, 9, 0);

    late List<ReminderSpec> specs;

    setUp(() {
      final item = lensItem(type: LensType.quarterly, activatedAt: activatedAt);
      specs = schedule.buildFor(item, now: activatedAt);
    });

    test('produces exactly 3 specs', () => expect(specs, hasLength(3)));

    test('first spec fires 7 days before expiry — offset day 83', () {
      expect(specs[0].fireAt, activatedAt.add(const Duration(days: 83)));
    });

    test('second spec fires 3 days before expiry — offset day 87', () {
      expect(specs[1].fireAt, activatedAt.add(const Duration(days: 87)));
    });

    test('third spec fires 1 day before expiry — offset day 89', () {
      expect(specs[2].fireAt, activatedAt.add(const Duration(days: 89)));
    });

    test('IDs are base, base+1, base+2', () {
      expect(specs[0].id, baseId);
      expect(specs[1].id, baseId + 1);
      expect(specs[2].id, baseId + 2);
    });

    test('first spec has 7-day warning text', () {
      expect(specs[0].title, AppStrings.notifLensExpiryTitle(7));
      expect(specs[0].body, AppStrings.notifLensExpiryBody('My Lens', 7));
    });
  });

  group('buildFor — annual lens (365 days)', () {
    final activatedAt = DateTime(2025, 1, 1, 9, 0);

    late List<ReminderSpec> specs;

    setUp(() {
      final item = lensItem(type: LensType.annual, activatedAt: activatedAt);
      specs = schedule.buildFor(item, now: activatedAt);
    });

    test('produces exactly 3 specs', () => expect(specs, hasLength(3)));

    test('first spec fires 7 days before expiry — offset day 358', () {
      expect(specs[0].fireAt, activatedAt.add(const Duration(days: 358)));
    });

    test('second spec fires 3 days before expiry — offset day 362', () {
      expect(specs[1].fireAt, activatedAt.add(const Duration(days: 362)));
    });

    test('third spec fires 1 day before expiry — offset day 364', () {
      expect(specs[2].fireAt, activatedAt.add(const Duration(days: 364)));
    });

    test('IDs are base, base+1, base+2', () {
      expect(specs[0].id, baseId);
      expect(specs[1].id, baseId + 1);
      expect(specs[2].id, baseId + 2);
    });
  });

  group('idsPerLens', () {
    test('daily → 1', () => expect(schedule.idsPerLens(LensType.daily), 1));
    test(
      'biWeekly → 2',
      () => expect(schedule.idsPerLens(LensType.biWeekly), 2),
    );
    test('monthly → 2', () => expect(schedule.idsPerLens(LensType.monthly), 2));
    test(
      'quarterly → 3',
      () => expect(schedule.idsPerLens(LensType.quarterly), 3),
    );
    test('annual → 3', () => expect(schedule.idsPerLens(LensType.annual), 3));
  });
}
