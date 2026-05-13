import 'package:flutter/foundation.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/entities/user_profile.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/domain/repositories/eyewear_repository.dart';
import 'package:my_eyes/domain/repositories/eyewear_test_repository.dart';
import 'package:my_eyes/domain/repositories/prescription_repository.dart';
import 'package:my_eyes/domain/repositories/profile_repository.dart';

class DevSeeder {
  static Future<void> seed({
    required ProfileRepository profileRepo,
    required PrescriptionRepository prescriptionRepo,
    required EyewearRepository eyewearRepo,
    required EyewearTestRepository eyewearTestRepo,
  }) async {
    assert(kDebugMode, 'DevSeeder must only run in debug mode');

    final existing = await profileRepo.getProfile();
    if (existing == null) {
      await profileRepo.saveProfile(
        UserProfile(
          id: 'local-dev-user',
          username: 'Thanasis',
          updatedAt: DateTime.now(),
        ),
      );
    }

    final devDate = DateTime(2024, 6, 1);
    final now = DateTime.now();

    final devPrescription = Prescription(
      id: 'dev-prescription-1',
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

    final existingPrescriptions = await prescriptionRepo.getPrescriptions();
    if (existingPrescriptions.isEmpty) {
      await prescriptionRepo.savePrescription(devPrescription);
    }

    final existingEyewear = await eyewearRepo.getAll();
    if (existingEyewear.isEmpty) {
      await eyewearRepo.save(
        EyewearItem(
          id: 'dev-eyewear-1',
          name: 'Daily Frames',
          category: EyewearCategory.nearSightedGlasses,
          updatedAt: now,
          prescription: devPrescription,
        ),
      );

      await eyewearRepo.save(
        EyewearItem(
          id: 'dev-eyewear-2',
          name: 'Summer Shades',
          category: EyewearCategory.sunglasses,
          updatedAt: now,
        ),
      );
    }

    final existingTests = await eyewearTestRepo.getTests();
    if (existingTests.isEmpty) {
      // 4 tests for Daily Frames
      await eyewearTestRepo.saveTest(
        EyewearTest(
          id: 'dev-test-1',
          eyewearId: 'dev-eyewear-1',
          score: 82,
          takenAt: DateTime(2025, 4, 10),
        ),
      );
      await eyewearTestRepo.saveTest(
        EyewearTest(
          id: 'dev-test-2',
          eyewearId: 'dev-eyewear-1',
          score: 75,
          takenAt: DateTime(2025, 2, 20),
        ),
      );
      await eyewearTestRepo.saveTest(
        EyewearTest(
          id: 'dev-test-3',
          eyewearId: 'dev-eyewear-1',
          score: 68,
          takenAt: DateTime(2024, 11, 5),
        ),
      );
      await eyewearTestRepo.saveTest(
        EyewearTest(
          id: 'dev-test-4',
          eyewearId: 'dev-eyewear-1',
          score: 91,
          takenAt: DateTime(2024, 8, 14),
        ),
      );

      // 2 tests for Summer Shades
      await eyewearTestRepo.saveTest(
        EyewearTest(
          id: 'dev-test-5',
          eyewearId: 'dev-eyewear-2',
          score: 60,
          takenAt: DateTime(2025, 3, 1),
        ),
      );
      await eyewearTestRepo.saveTest(
        EyewearTest(
          id: 'dev-test-6',
          eyewearId: 'dev-eyewear-2',
          score: 55,
          takenAt: DateTime(2024, 9, 22),
        ),
      );
    }

    debugPrint('DevSeeder: mock data seeded');
  }
}
