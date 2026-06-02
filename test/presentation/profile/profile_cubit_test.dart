import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/entities/user_profile.dart';
import 'package:my_eyes/domain/repositories/eyewear_test_repository.dart';
import 'package:my_eyes/domain/repositories/prescription_repository.dart';
import 'package:my_eyes/domain/repositories/profile_repository.dart';
import 'package:my_eyes/presentation/profile/cubit/profile_cubit.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

class MockPrescriptionRepository extends Mock
    implements PrescriptionRepository {}

class MockEyewearTestRepository extends Mock implements EyewearTestRepository {}

class FakeUserProfile extends Fake implements UserProfile {}

class FakePrescription extends Fake implements Prescription {}

void main() {
  late MockProfileRepository profileRepo;
  late MockPrescriptionRepository prescriptionRepo;
  late MockEyewearTestRepository testRepo;

  setUpAll(() {
    registerFallbackValue(FakeUserProfile());
    registerFallbackValue(FakePrescription());
  });

  final tDate = DateTime(2024, 1, 15);

  final tProfile = UserProfile(
    id: 'u1',
    username: 'Thanasis',
    email: 'test@email.com',
    updatedAt: tDate,
  );

  final tPrescription = Prescription(
    id: 'p1',
    label: 'Current',
    issueDate: tDate,
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
    updatedAt: tDate,
  );

  setUp(() {
    profileRepo = MockProfileRepository();
    prescriptionRepo = MockPrescriptionRepository();
    testRepo = MockEyewearTestRepository();
  });

  ProfileCubit buildCubit() =>
      ProfileCubit(profileRepo, prescriptionRepo, testRepo);

  group('loadProfile', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits loading then loaded with profile, prescription and test count',
      build: () {
        when(() => profileRepo.getProfile()).thenAnswer((_) async => tProfile);
        when(
          () => prescriptionRepo.getPrescriptions(),
        ).thenAnswer((_) async => [tPrescription]);
        when(() => testRepo.getCount()).thenAnswer((_) async => 7);
        return buildCubit();
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [
        const ProfileLoading(),
        isA<ProfileLoaded>()
            .having((s) => s.profile.id, 'profile.id', 'u1')
            .having(
              (s) => s.latestPrescription?.id,
              'latestPrescription.id',
              'p1',
            )
            .having((s) => s.testCount, 'testCount', 7),
      ],
      verify: (_) => verify(() => testRepo.getCount()).called(1),
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits loaded with null prescription and zero count when none exist',
      build: () {
        when(() => profileRepo.getProfile()).thenAnswer((_) async => tProfile);
        when(
          () => prescriptionRepo.getPrescriptions(),
        ).thenAnswer((_) async => []);
        when(() => testRepo.getCount()).thenAnswer((_) async => 0);
        return buildCubit();
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [
        const ProfileLoading(),
        isA<ProfileLoaded>()
            .having((s) => s.latestPrescription, 'latestPrescription', isNull)
            .having((s) => s.testCount, 'testCount', 0),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits error when profile is null',
      build: () {
        when(() => profileRepo.getProfile()).thenAnswer((_) async => null);
        return buildCubit();
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [
        const ProfileLoading(),
        const ProfileError('No profile found'),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits error when repository throws',
      build: () {
        when(
          () => profileRepo.getProfile(),
        ).thenThrow(Exception('storage error'));
        return buildCubit();
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [const ProfileLoading(), isA<ProfileError>()],
    );
  });

  group('saveProfile', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits updated loaded state with new username and email',
      build: () {
        when(() => profileRepo.updateProfile(any())).thenAnswer((_) async {});
        return buildCubit()..emit(
          ProfileLoaded(profile: tProfile, latestPrescription: tPrescription),
        );
      },
      act: (cubit) =>
          cubit.saveProfile(username: 'NewName', email: 'newemail@mail.com'),
      expect: () => [
        isA<ProfileLoaded>()
            .having((s) => s.profile.username, 'username', 'NewName')
            .having((s) => s.profile.email, 'email', 'newemail@mail.com'),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'does nothing when state is not loaded',
      build: () => buildCubit(),
      act: (cubit) =>
          cubit.saveProfile(username: 'NewName', email: 'newemail@mail.com'),
      expect: () => [],
    );
  });

  group('addPrescription', () {
    blocTest<ProfileCubit, ProfileState>(
      'saves prescription and emits updated loaded state',
      build: () {
        when(
          () => prescriptionRepo.savePrescription(any()),
        ).thenAnswer((_) async {});
        return buildCubit()
          ..emit(ProfileLoaded(profile: tProfile, latestPrescription: null));
      },
      act: (cubit) => cubit.addPrescription(tPrescription),
      expect: () => [
        isA<ProfileLoaded>().having(
          (s) => s.latestPrescription?.id,
          'id',
          'p1',
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'does nothing when state is not loaded',
      build: () => buildCubit(),
      act: (cubit) => cubit.addPrescription(tPrescription),
      expect: () => [],
    );
  });

  group('editPrescription', () {
    blocTest<ProfileCubit, ProfileState>(
      'saves prescription and emits updated loaded state with refreshed updatedAt',
      build: () {
        when(
          () => prescriptionRepo.updatePrescription(any()),
        ).thenAnswer((_) async {});
        return buildCubit()..emit(
          ProfileLoaded(profile: tProfile, latestPrescription: tPrescription),
        );
      },
      act: (cubit) =>
          cubit.editPrescription(tPrescription.copyWith(notes: 'updated')),
      expect: () => [
        isA<ProfileLoaded>().having(
          (s) => s.latestPrescription?.notes,
          'notes',
          'updated',
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'does nothing when state is not loaded',
      build: () => buildCubit(),
      act: (cubit) => cubit.editPrescription(tPrescription),
      expect: () => [],
    );
  });
}
