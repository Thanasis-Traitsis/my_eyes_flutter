import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
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

  Future<void> updateItem(EyewearItem item) async {
    try {
      await _repository.update(item);
      await loadEyewear();
    } catch (e) {
      emit(EyewearError(e.toString()));
    }
  }

  Future<void> deactivateLens(EyewearItem item) async {
    final supply = item.contactLensSupply;
    if (supply == null) return;

    final deactivated = item.copyWith(
      contactLensSupply: supply.copyWith(activatedAt: null),
    );

    try {
      await _repository.update(deactivated);
      await loadEyewear();
    } catch (e) {
      emit(EyewearError(e.toString()));
    }
  }

  Future<void> updateLensActivation(
    EyewearItem item, {
    required DateTime activatedAt,
  }) async {
    final supply = item.contactLensSupply;
    if (supply == null) return;

    final updated = item.copyWith(
      contactLensSupply: supply.copyWith(activatedAt: activatedAt),
    );

    try {
      await _repository.update(updated);
      await loadEyewear();
    } catch (e) {
      emit(EyewearError(e.toString()));
    }
  }

  Future<void> activateLens(
    EyewearItem item, {
    required DateTime activatedAt,
  }) async {
    final supply = item.contactLensSupply;
    if (supply == null || supply.quantity <= 0) return;

    final activated = item.copyWith(
      contactLensSupply: supply.copyWith(
        activatedAt: activatedAt,
        quantity: supply.quantity - 1,
      ),
    );

    try {
      await _repository.update(activated);
      await loadEyewear();
    } catch (e) {
      emit(EyewearError(e.toString()));
    }
  }

  Future<void> deleteItem(EyewearItem item) async {
    try {
      await _repository.delete(item.id);
      await loadEyewear();
    } catch (e) {
      emit(EyewearError(e.toString()));
    }
  }
}
