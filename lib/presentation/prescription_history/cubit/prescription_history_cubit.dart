import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_eyes/core/constants/app_values.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/repositories/prescription_repository.dart';

part 'prescription_history_state.dart';

class PrescriptionHistoryCubit extends Cubit<PrescriptionHistoryState> {
  PrescriptionHistoryCubit(this._repository)
    : super(const PrescriptionHistoryInitial());

  final PrescriptionRepository _repository;

  Future<void> loadFirstPage() async {
    emit(const PrescriptionHistoryLoading());
    try {
      final items = await _repository.getPrescriptionsPaged(
        offset: 0,
        limit: AppValues.kPrescriptionHistoryPageSize,
      );
      final hasMore = items.length == AppValues.kPrescriptionHistoryPageSize;
      emit(
        PrescriptionHistoryLoaded(
          items: items,
          hasMore: hasMore,
          isFetchingMore: false,
        ),
      );
    } catch (e) {
      emit(PrescriptionHistoryError(e.toString()));
    }
  }

  Future<void> loadNextPage() async {
    final current = state;
    if (current is! PrescriptionHistoryLoaded) return;
    if (!current.hasMore || current.isFetchingMore) return;

    emit(current.copyWith(isFetchingMore: true));
    try {
      final newItems = await _repository.getPrescriptionsPaged(
        offset: current.items.length,
        limit: AppValues.kPrescriptionHistoryPageSize,
      );
      final hasMore = newItems.length == AppValues.kPrescriptionHistoryPageSize;
      emit(
        current.copyWith(
          items: [...current.items, ...newItems],
          hasMore: hasMore,
          isFetchingMore: false,
        ),
      );
    } catch (e) {
      emit(current.copyWith(isFetchingMore: false));
    }
  }
}
