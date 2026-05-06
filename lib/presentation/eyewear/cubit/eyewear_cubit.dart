import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/repositories/eyewear_repository.dart';

part 'eyewear_state.dart';

@singleton
class EyewearCubit extends Cubit<EyewearState> {
  EyewearCubit(this._repository) : super(const EyewearInitial());

  final EyewearRepository _repository;

  Future<void> loadEyewear() async {
    emit(const EyewearLoading());
    try {
      final items = await _repository.getAll();
      emit(EyewearLoaded(items: items));
    } catch (e) {
      emit(EyewearError(e.toString()));
    }
  }

  Future<void> addItem(EyewearItem item) async {
    try {
      await _repository.save(item);
      await loadEyewear();
    } catch (e) {
      emit(EyewearError(e.toString()));
    }
  }
}
