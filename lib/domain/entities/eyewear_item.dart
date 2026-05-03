import 'package:equatable/equatable.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';

class EyewearItem extends Equatable {
  const EyewearItem({
    required this.id,
    required this.name,
    required this.category,
    required this.updatedAt,
    this.prescription,
  });

  final String id;
  final String name;
  final EyewearCategory category;
  final DateTime updatedAt;
  final Prescription? prescription;

  EyewearItem copyWith({
    String? id,
    String? name,
    EyewearCategory? category,
    DateTime? updatedAt,
    Prescription? prescription,
  }) {
    return EyewearItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      updatedAt: updatedAt ?? this.updatedAt,
      prescription: prescription ?? this.prescription,
    );
  }

  @override
  List<Object?> get props => [id, name, category, updatedAt, prescription];
}
