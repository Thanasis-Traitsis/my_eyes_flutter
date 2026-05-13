import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/domain/repositories/eyewear_test_repository.dart';

part 'eyewear_test_state.dart';

@singleton
class EyewearTestCubit extends Cubit<EyewearTestState> {
  EyewearTestCubit(this._repository) : super(const EyewearTestInitial());

  final EyewearTestRepository _repository;

  Future<void> loadTests() async {
    emit(const EyewearTestLoading());
    try {
      final tests = await _repository.getTests();
      emit(EyewearTestLoaded(tests: tests));
    } catch (e) {
      emit(EyewearTestError(e.toString()));
    }
  }
}
