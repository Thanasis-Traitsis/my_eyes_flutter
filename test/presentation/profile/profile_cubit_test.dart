import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/entities/user_profile.dart';
import 'package:my_eyes/domain/repositories/prescription_repository.dart';
import 'package:my_eyes/domain/repositories/profile_repository.dart';
import 'package:my_eyes/presentation/profile/cubit/profile_cubit.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

class MockPrescriptionRepository extends Mock
    implements PrescriptionRepository {}

class FakeUserProfile extends Fake implements UserProfile {}

void main() {
  late MockProfileRepository profileRepo;
  late MockPrescriptionRepository prescriptionRepo;

  setUpAll(() => registerFallbackValue(FakeUserProfile()));

  final tDate = DateTime(2024, 1, 15);

  final tProfile = UserProfile(
    id: 'u1',
    username: 'Thanasis',
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
  });

  ProfileCubit buildCubit() => ProfileCubit(profileRepo, prescriptionRepo);

  group('loadProfile', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits loading then loaded with profile and prescription',
      build: () {
        when(() => profileRepo.getProfile()).thenAnswer((_) async => tProfile);
        when(
          () => prescriptionRepo.getPrescriptions(),
        ).thenAnswer((_) async => [tPrescription]);
        return buildCubit();
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [
        const ProfileLoading(),
        ProfileLoaded(profile: tProfile, latestPrescription: tPrescription),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits loaded with null prescription when none exist',
      build: () {
        when(() => profileRepo.getProfile()).thenAnswer((_) async => tProfile);
        when(
          () => prescriptionRepo.getPrescriptions(),
        ).thenAnswer((_) async => []);
        return buildCubit();
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [
        const ProfileLoading(),
        ProfileLoaded(profile: tProfile, latestPrescription: null),
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

  group('updateUsername', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits updated loaded state with new username',
      build: () {
        when(() => profileRepo.updateProfile(any())).thenAnswer((_) async {});
        return buildCubit()..emit(
          ProfileLoaded(profile: tProfile, latestPrescription: tPrescription),
        );
      },
      act: (cubit) => cubit.updateUsername('NewName'),
      expect: () => [
        isA<ProfileLoaded>().having(
          (s) => s.profile.username,
          'username',
          'NewName',
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'does nothing when state is not loaded',
      build: () => buildCubit(),
      act: (cubit) => cubit.updateUsername('NewName'),
      expect: () => [],
    );
  });
}
