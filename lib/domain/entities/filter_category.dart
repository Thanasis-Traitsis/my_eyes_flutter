import 'package:equatable/equatable.dart';
import 'package:my_eyes/domain/enums/test_filter_key.dart';

class FilterOption extends Equatable {
  const FilterOption({required this.id, required this.label});

  final String id;
  final String label;

  @override
  List<Object?> get props => [id, label];
}

class FilterCategory extends Equatable {
  const FilterCategory({required this.key, required this.options});

  final TestFilterKey key;
  final List<FilterOption> options;

  String get label => key.label;

  @override
  List<Object?> get props => [key, options];
}
