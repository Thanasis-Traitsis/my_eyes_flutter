import 'package:flutter/foundation.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/entities/user_profile.dart';
import 'package:my_eyes/domain/repositories/prescription_repository.dart';
import 'package:my_eyes/domain/repositories/profile_repository.dart';

class DevSeeder {
  static Future<void> seed({
    required ProfileRepository profileRepo,
    required PrescriptionRepository prescriptionRepo,
  }) async {
    assert(kDebugMode, 'DevSeeder must only run in debug mode');

    final existing = await profileRepo.getProfile();
    if (existing != null) return;

    await profileRepo.saveProfile(
      UserProfile(
        id: 'local-dev-user',
        username: 'Thanasis',
        updatedAt: DateTime.now(),
      ),
    );

    await prescriptionRepo.savePrescription(
      Prescription(
        id: 'dev-prescription-1',
        label: 'Current',
        issueDate: DateTime(2024, 6, 1),
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
        updatedAt: DateTime.now(),
      ),
    );

    debugPrint('DevSeeder: mock data seeded');
  }
}
