import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';

class EyewearItem extends Equatable {
  const EyewearItem({
    required this.id,
    required this.name,
    required this.category,
    required this.updatedAt,
    this.selectedOptionIndex = 0,
    this.colorValue = 0xFF9E9EAF,
    this.prescription,
  });

  final String id;
  final String name;
  final EyewearCategory category;
  final DateTime updatedAt;
  final int selectedOptionIndex;
  final int colorValue;

  Color get color => Color(colorValue);

  final Prescription? prescription;

  EyewearItem copyWith({
    String? id,
    String? name,
    EyewearCategory? category,
    DateTime? updatedAt,
    int? selectedOptionIndex,
    int? colorValue,
    Prescription? prescription,
  }) {
    return EyewearItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      updatedAt: updatedAt ?? this.updatedAt,
      selectedOptionIndex: selectedOptionIndex ?? this.selectedOptionIndex,
      colorValue: colorValue ?? this.colorValue,
      prescription: prescription ?? this.prescription,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    updatedAt,
    selectedOptionIndex,
    colorValue,
    prescription,
  ];
}
