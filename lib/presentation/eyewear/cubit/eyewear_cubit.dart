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
      emit(EyewearLoaded(items: items, selectedIndex: 0));
    } catch (e) {
      emit(EyewearError(e.toString()));
    }
  }

  void selectItem(int index) {
    final current = state;
    if (current is! EyewearLoaded) return;
    if (index < 0 || index >= current.items.length) return;
    emit(current.copyWith(selectedIndex: index));
  }
}
