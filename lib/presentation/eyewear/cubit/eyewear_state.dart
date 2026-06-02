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

  List<EyewearItem> get contactLenses =>
      items.where((i) => i.category == EyewearCategory.contactLenses).toList();

  int get glassesCount =>
      items.where((i) => i.category != EyewearCategory.contactLenses).length;

  EyewearLoaded copyWith({List<EyewearItem>? items}) {
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
