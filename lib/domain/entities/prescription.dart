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
    this.doctor,
    this.notes,
    this.reminderMonths,
  });

  final String id;
  final String label;
  final DateTime issueDate;
  final EyeMeasurement rightEye; // OD
  final EyeMeasurement leftEye; // OS
  final DateTime updatedAt;
  final String? doctor;
  final String? notes;
  final int? reminderMonths; // 3, 6, or 12

  Prescription copyWith({
    String? id,
    String? label,
    DateTime? issueDate,
    EyeMeasurement? rightEye,
    EyeMeasurement? leftEye,
    DateTime? updatedAt,
    String? doctor,
    String? notes,
    int? reminderMonths,
  }) {
    return Prescription(
      id: id ?? this.id,
      label: label ?? this.label,
      issueDate: issueDate ?? this.issueDate,
      rightEye: rightEye ?? this.rightEye,
      leftEye: leftEye ?? this.leftEye,
      updatedAt: updatedAt ?? this.updatedAt,
      doctor: doctor ?? this.doctor,
      notes: notes ?? this.notes,
      reminderMonths: reminderMonths ?? this.reminderMonths,
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
    doctor,
    notes,
    reminderMonths,
  ];
}
