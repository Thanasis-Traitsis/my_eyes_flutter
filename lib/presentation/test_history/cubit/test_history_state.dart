part of 'test_history_cubit.dart';

sealed class TestHistoryState extends Equatable {
  const TestHistoryState();

  @override
  List<Object?> get props => [];
}

class TestHistoryInitial extends TestHistoryState {
  const TestHistoryInitial();
}

class TestHistoryLoading extends TestHistoryState {
  const TestHistoryLoading({required this.filters});

  final Set<String> filters;

  @override
  List<Object?> get props => [filters];
}

final class TestHistoryLoaded extends TestHistoryState {
  const TestHistoryLoaded({
    required this.items,
    required this.filters,
    required this.hasMore,
    required this.isFetchingMore,
  });

  final List<EyewearTest> items;
  final Set<String> filters;
  final bool hasMore;
  final bool isFetchingMore;

  TestHistoryLoaded copyWith({
    List<EyewearTest>? items,
    Set<String>? filters,
    bool? hasMore,
    bool? isFetchingMore,
  }) {
    return TestHistoryLoaded(
      items: items ?? this.items,
      filters: filters ?? this.filters,
      hasMore: hasMore ?? this.hasMore,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }

  @override
  List<Object?> get props => [items, filters, hasMore, isFetchingMore];
}

class TestHistoryError extends TestHistoryState {
  const TestHistoryError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
