part of 'eyewear_test_cubit.dart';

sealed class EyewearTestState extends Equatable {
  const EyewearTestState();

  @override
  List<Object?> get props => [];
}

class EyewearTestInitial extends EyewearTestState {
  const EyewearTestInitial();
}

class EyewearTestLoading extends EyewearTestState {
  const EyewearTestLoading();
}

final class EyewearTestLoaded extends EyewearTestState {
  const EyewearTestLoaded({required this.tests});

  /// The full unfiltered list of all tests.
  final List<EyewearTest> tests;

  @override
  List<Object?> get props => [tests];
}

class EyewearTestError extends EyewearTestState {
  const EyewearTestError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
