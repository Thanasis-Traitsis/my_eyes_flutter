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
  const EyewearLoaded({required this.items, required this.selectedIndex});

  final List<EyewearItem> items;
  final int selectedIndex;

  EyewearItem? get selectedItem =>
      items.isNotEmpty ? items[selectedIndex] : null;

  EyewearLoaded copyWith({List<EyewearItem>? items, int? selectedIndex}) {
    return EyewearLoaded(
      items: items ?? this.items,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [items, selectedIndex];
}

class EyewearError extends EyewearState {
  const EyewearError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
