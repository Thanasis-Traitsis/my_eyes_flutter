import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:my_eyes/core/constants/app_avatars.dart';
import 'package:my_eyes/domain/entities/calendar_event.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/entities/user_profile.dart';
import 'package:my_eyes/domain/enums/calendar_event_type.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/domain/repositories/calendar_event_repository.dart';
import 'package:my_eyes/domain/repositories/eyewear_repository.dart';
import 'package:my_eyes/domain/repositories/eyewear_test_repository.dart';
import 'package:my_eyes/domain/repositories/prescription_repository.dart';
import 'package:my_eyes/domain/repositories/profile_repository.dart';

class DevSeeder {
  static const _eyewear1Id = 'dev-eyewear-1';
  static const _eyewear2Id = 'dev-eyewear-2';
  static const _devPrescriptionId = 'dev-prescription-1';

  static Future<void> seed({
    required ProfileRepository profileRepo,
    required PrescriptionRepository prescriptionRepo,
    required EyewearRepository eyewearRepo,
    required EyewearTestRepository eyewearTestRepo,
    required CalendarEventRepository calendarRepo,
  }) async {
    assert(kDebugMode, 'DevSeeder must only run in debug mode');

    final now = DateTime.now();
    final devDate = DateTime(2024, 6, 1);

    final avatar = AppAvatars.all[Random().nextInt(AppAvatars.all.length)];
    await profileRepo.saveProfile(
      UserProfile(
        id: 'local-dev-user',
        username: 'Thanasis',
        updatedAt: now,
        avatarUrl: avatar,
      ),
    );

    final devPrescription = Prescription(
      id: _devPrescriptionId,
      label: 'Current',
      issueDate: devDate,
      rightEye: const EyeMeasurement(
        sphere: -2.5,
        cylinder: -0.75,
        axis: 180,
        addition: 0,
        pd: 62,
      ),
      leftEye: const EyeMeasurement(
        sphere: -2.25,
        cylinder: -0.5,
        axis: 170,
        addition: 0,
        pd: 62,
      ),
      updatedAt: now,
    );

    if ((await prescriptionRepo.getPrescriptions()).isEmpty) {
      await prescriptionRepo.savePrescription(devPrescription);
    }

    final existingEyewear = await eyewearRepo.getAll();
    for (final item in existingEyewear) {
      await eyewearRepo.delete(item.id);
    }
    await eyewearTestRepo.clearAllTests();

    await eyewearRepo.save(
      EyewearItem(
        id: _eyewear1Id,
        name: 'Daily Frames',
        category: EyewearCategory.nearSightedGlasses,
        updatedAt: now,
        prescription: devPrescription,
        colorValue: 0xff69140E,
      ),
    );
    await eyewearRepo.save(
      EyewearItem(
        id: _eyewear2Id,
        name: 'Summer Shades',
        category: EyewearCategory.sunglasses,
        updatedAt: now,
        colorValue: 0xffBA5A31,
      ),
    );

    for (final test in _testsFor(_eyewear1Id, _eyewear2Id)) {
      await eyewearTestRepo.saveTest(test);
    }

    final existingEvents = await calendarRepo.getEvents();
    for (final event in existingEvents) {
      await calendarRepo.deleteEvent(event.id);
    }
    for (final event in _calendarEvents()) {
      await calendarRepo.saveEvent(event);
    }

    debugPrint('DevSeeder: data reseeded');
  }

  static List<CalendarEvent> _calendarEvents() => [
    CalendarEvent(
      id: 'dev-cal-1',
      date: DateTime(2026, 6, 15),
      title: 'Eye Exam',
      type: CalendarEventType.custom,
      description: "test description",
    ),
    CalendarEvent(
      id: 'dev-cal-2',
      date: DateTime(2026, 6, 28),
      title: 'Lens replacement',
      type: CalendarEventType.custom,
    ),
    CalendarEvent(
      id: 'dev-cal-3',
      date: DateTime(2026, 8, 5),
      title: 'Lens replacement',
      type: CalendarEventType.custom,
      description: "this is a random description text",
    ),
    CalendarEvent(
      id: 'dev-cal-4',
      date: DateTime(2025, 9, 10),
      title: 'Annual Eye Check',
      type: CalendarEventType.custom,
    ),
  ];

  static List<EyewearTest> _testsFor(String e1, String e2) => [
    EyewearTest(
      id: 'dev-test-1',
      eyewearId: e1,
      score: 82,
      takenAt: DateTime(2026, 10, 10),
    ),
    EyewearTest(
      id: 'dev-test-2',
      eyewearId: e1,
      score: 75,
      takenAt: DateTime(2026, 2, 20),
    ),
    EyewearTest(
      id: 'dev-test-3',
      eyewearId: e1,
      score: 68,
      takenAt: DateTime(2026, 11, 5),
    ),
    EyewearTest(
      id: 'dev-test-4',
      eyewearId: e1,
      score: 91,
      takenAt: DateTime(2026, 8, 14),
    ),
    EyewearTest(
      id: 'dev-test-5',
      eyewearId: e2,
      score: 60,
      takenAt: DateTime(2025, 3, 1),
    ),
    EyewearTest(
      id: 'dev-test-6',
      eyewearId: e2,
      score: 55,
      takenAt: DateTime(2025, 9, 22),
    ),
    EyewearTest(
      id: 'dev-test-7',
      eyewearId: e2,
      score: 25,
      takenAt: DateTime(2025, 6, 12),
    ),
    EyewearTest(
      id: 'dev-test-8',
      eyewearId: e1,
      score: 75,
      takenAt: DateTime(2025, 4, 09),
    ),
    EyewearTest(
      id: 'dev-test-9',
      eyewearId: e2,
      score: 69,
      takenAt: DateTime(2024, 9, 23),
    ),
  ];
}
