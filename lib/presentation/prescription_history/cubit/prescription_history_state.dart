part of 'prescription_history_cubit.dart';

sealed class PrescriptionHistoryState extends Equatable {
  const PrescriptionHistoryState();

  @override
  List<Object?> get props => [];
}

class PrescriptionHistoryInitial extends PrescriptionHistoryState {
  const PrescriptionHistoryInitial();
}

class PrescriptionHistoryLoading extends PrescriptionHistoryState {
  const PrescriptionHistoryLoading();
}

final class PrescriptionHistoryLoaded extends PrescriptionHistoryState {
  const PrescriptionHistoryLoaded({
    required this.items,
    required this.hasMore,
    required this.isFetchingMore,
  });

  final List<Prescription> items;
  final bool hasMore;
  final bool isFetchingMore;

  PrescriptionHistoryLoaded copyWith({
    List<Prescription>? items,
    bool? hasMore,
    bool? isFetchingMore,
  }) {
    return PrescriptionHistoryLoaded(
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }

  @override
  List<Object?> get props => [items, hasMore, isFetchingMore];
}

class PrescriptionHistoryError extends PrescriptionHistoryState {
  const PrescriptionHistoryError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
