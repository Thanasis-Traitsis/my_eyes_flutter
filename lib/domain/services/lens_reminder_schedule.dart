import 'package:injectable/injectable.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/entities/reminder_spec.dart';
import 'package:my_eyes/domain/enums/lens_type.dart';

@singleton
class LensReminderSchedule {
  const LensReminderSchedule();

  List<ReminderSpec> buildFor(EyewearItem item, {DateTime? now}) {
    final supply = item.contactLensSupply;
    if (supply == null || supply.activatedAt == null) return const [];

    final activatedAt = supply.activatedAt!;
    final baseId = _baseId(item);
    final name = item.name;

    final specs = switch (supply.lensType) {
      LensType.daily => [
        _spec(
          id: baseId,
          fireAt: _next2000(activatedAt),
          title: AppStrings.notifLensDailyTitle,
          body: AppStrings.notifLensDailyBody(name),
        ),
      ],
      LensType.biWeekly => _expiryReminders(
        activatedAt,
        baseId,
        name,
        LensType.biWeekly.totalDays,
      ),
      LensType.monthly => _expiryReminders(
        activatedAt,
        baseId,
        name,
        LensType.monthly.totalDays,
      ),
      LensType.quarterly => _expiryReminders(
        activatedAt,
        baseId,
        name,
        LensType.quarterly.totalDays,
        includeWeek: true,
      ),
      LensType.annual => _expiryReminders(
        activatedAt,
        baseId,
        name,
        LensType.annual.totalDays,
        includeWeek: true,
      ),
    };

    final cutoff = now ?? DateTime.now();
    return specs.where((s) => s.fireAt.isAfter(cutoff)).toList();
  }

  int idsPerLens(LensType type) => switch (type) {
    LensType.daily => 1,
    LensType.biWeekly => 2,
    LensType.monthly => 2,
    LensType.quarterly => 3,
    LensType.annual => 3,
  };

  int _baseId(EyewearItem item) => item.id.hashCode.abs() % 100000;

  List<ReminderSpec> _expiryReminders(
    DateTime activatedAt,
    int baseId,
    String name,
    int totalDays, {
    bool includeWeek = false,
  }) {
    final specs = <ReminderSpec>[];
    var slot = 0;

    if (includeWeek) {
      specs.add(
        _spec(
          id: baseId + slot++,
          fireAt: _offsetDays(activatedAt, totalDays - 7),
          title: AppStrings.notifLensExpiryTitle(7),
          body: AppStrings.notifLensExpiryBody(name, 7),
        ),
      );
    }

    specs.add(
      _spec(
        id: baseId + slot++,
        fireAt: _offsetDays(activatedAt, totalDays - 3),
        title: AppStrings.notifLensExpiryTitle(3),
        body: AppStrings.notifLensExpiryBody(name, 3),
      ),
    );

    specs.add(
      _spec(
        id: baseId + slot++,
        fireAt: _offsetDays(activatedAt, totalDays - 1),
        title: AppStrings.notifLensExpiryTomorrowTitle,
        body: AppStrings.notifLensExpiryTomorrowBody(name),
      ),
    );

    return specs;
  }

  ReminderSpec _spec({
    required int id,
    required DateTime fireAt,
    required String title,
    required String body,
  }) => ReminderSpec(id: id, fireAt: fireAt, title: title, body: body);

  DateTime _next2000(DateTime from) {
    final today2000 = DateTime(from.year, from.month, from.day, 20, 0);
    return from.isBefore(today2000)
        ? today2000
        : today2000.add(const Duration(days: 1));
  }

  DateTime _offsetDays(DateTime from, int days) => DateTime(
    from.year,
    from.month,
    from.day,
    from.hour,
    from.minute,
  ).add(Duration(days: days));
}
