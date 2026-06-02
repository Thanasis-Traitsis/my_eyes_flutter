part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded({
    required this.profile,
    required this.latestPrescription,
    this.testCount = 0,
    this.saveError,
  });

  final UserProfile profile;
  final Prescription? latestPrescription;
  final int testCount;
  final String? saveError;

  ProfileLoaded copyWith({
    UserProfile? profile,
    Prescription? latestPrescription,
    int? testCount,
    String? saveError,
  }) => ProfileLoaded(
    profile: profile ?? this.profile,
    latestPrescription: latestPrescription ?? this.latestPrescription,
    testCount: testCount ?? this.testCount,
    saveError: saveError,
  );

  @override
  List<Object?> get props => [
    profile,
    latestPrescription,
    testCount,
    saveError,
  ];
}

class ProfileError extends ProfileState {
  const ProfileError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
