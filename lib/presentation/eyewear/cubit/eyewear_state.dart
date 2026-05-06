part of 'eyewear_cubit.dart';

sealed class EyewearState extends Equatable {
  const EyewearState();

  @override
  List<Object?> get props => [];
}

class EyewearInitial extends EyewearState {
  const EyewearInitial();
}

class EyewearLoading extends EyewearState {
  const EyewearLoading();
}

final class EyewearLoaded extends EyewearState {
  const EyewearLoaded({required this.items});

  final List<EyewearItem> items;

  EyewearLoaded copyWith({List<EyewearItem>? items, int? selectedIndex}) {
    return EyewearLoaded(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}

class EyewearError extends EyewearState {
  const EyewearError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
