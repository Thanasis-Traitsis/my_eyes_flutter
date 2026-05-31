import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/entities/user_profile.dart';
import 'package:my_eyes/domain/repositories/prescription_repository.dart';
import 'package:my_eyes/domain/repositories/profile_repository.dart';

part 'profile_state.dart';

@singleton
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository, this._prescriptionRepository)
    : super(const ProfileInitial());

  final ProfileRepository _profileRepository;
  final PrescriptionRepository _prescriptionRepository;

  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    try {
      final profile = await _profileRepository.getProfile();
      if (profile == null) {
        emit(const ProfileError(AppStrings.profileNotFoundError));
        return;
      }

      final prescriptions = await _prescriptionRepository.getPrescriptions();
      final latest = prescriptions.isNotEmpty ? prescriptions.first : null;

      emit(ProfileLoaded(profile: profile, latestPrescription: latest));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> editPrescription(Prescription prescription) async {
    final current = state;
    if (current is! ProfileLoaded) return;

    try {
      final stamped = prescription.copyWith(updatedAt: DateTime.now());
      await _prescriptionRepository.updatePrescription(stamped);
      emit(
        ProfileLoaded(profile: current.profile, latestPrescription: stamped),
      );
    } catch (e) {
      emit(current.copyWith(saveError: e.toString()));
    }
  }

  Future<void> addPrescription(Prescription prescription) async {
    final current = state;
    if (current is! ProfileLoaded) return;

    try {
      await _prescriptionRepository.savePrescription(prescription);
      emit(
        ProfileLoaded(
          profile: current.profile,
          latestPrescription: prescription,
        ),
      );
    } catch (e) {
      emit(current.copyWith(saveError: e.toString()));
    }
  }

  Future<void> saveProfile({
    required String username,
    required String email,
    Prescription? updatedPrescription,
  }) async {
    final current = state;
    if (current is! ProfileLoaded) return;

    final updatedProfile = current.profile.copyWith(
      username: username,
      email: email,
      updatedAt: DateTime.now(),
    );

    try {
      await _profileRepository.updateProfile(updatedProfile);
      if (updatedPrescription != null) {
        await _prescriptionRepository.updatePrescription(updatedPrescription);
      }

      emit(
        ProfileLoaded(
          profile: updatedProfile,
          latestPrescription: updatedPrescription ?? current.latestPrescription,
        ),
      );
    } catch (e) {
      emit(current.copyWith(saveError: e.toString()));
    }
  }
}
