import 'package:equatable/equatable.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';

class Prescription extends Equatable {
  const Prescription({
    required this.id,
    required this.label,
    required this.issueDate,
    required this.rightEye,
    required this.leftEye,
    required this.updatedAt,
  });

  final String id;
  final String label;
  final DateTime issueDate;
  final EyeMeasurement rightEye; // OD
  final EyeMeasurement leftEye; // OS
  final DateTime updatedAt;

  Prescription copyWith({
    String? id,
    String? label,
    DateTime? issueDate,
    EyeMeasurement? rightEye,
    EyeMeasurement? leftEye,
    DateTime? updatedAt,
  }) {
    return Prescription(
      id: id ?? this.id,
      label: label ?? this.label,
      issueDate: issueDate ?? this.issueDate,
      rightEye: rightEye ?? this.rightEye,
      leftEye: leftEye ?? this.leftEye,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    label,
    issueDate,
    rightEye,
    leftEye,
    updatedAt,
  ];
}
