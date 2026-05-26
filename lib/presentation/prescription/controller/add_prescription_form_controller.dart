import 'package:flutter/widgets.dart';
import 'package:my_eyes/core/utils/date_extensions.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/prescription.dart';

class AddPrescriptionFormController {
  AddPrescriptionFormController() {
    doctor = TextEditingController();
    notes = TextEditingController();
    sphereRight = TextEditingController();
    cylinderRight = TextEditingController();
    axisRight = TextEditingController();
    sphereLeft = TextEditingController();
    cylinderLeft = TextEditingController();
    axisLeft = TextEditingController();
  }

  late final TextEditingController doctor;
  late final TextEditingController notes;
  late final TextEditingController sphereRight;
  late final TextEditingController cylinderRight;
  late final TextEditingController axisRight;
  late final TextEditingController sphereLeft;
  late final TextEditingController cylinderLeft;
  late final TextEditingController axisLeft;
  DateTime issueDate = DateTime.now();
  int? reminderMonths;

  final Map<TextEditingController, bool> _validityMap = {};

  List<TextEditingController> get prescriptionControllers => [
    sphereRight,
    cylinderRight,
    axisRight,
    sphereLeft,
    cylinderLeft,
    axisLeft,
  ];

  List<TextEditingController> get allControllers => [
    doctor,
    notes,
    ...prescriptionControllers,
  ];

  void setValidity(TextEditingController controller, bool isValid) {
    _validityMap[controller] = isValid;
  }

  bool get isPrescriptionValid =>
      _validityMap.length == prescriptionControllers.length &&
      _validityMap.values.every((v) => v);

  Prescription build({Prescription? existing}) {
    final now = DateTime.now();
    return Prescription(
      id: existing?.id ?? 'rx-${now.millisecondsSinceEpoch}',
      label: issueDate.formattedDate,
      issueDate: issueDate,
      rightEye: EyeMeasurement(
        sphere: double.tryParse(sphereRight.text) ?? 0,
        cylinder: double.tryParse(cylinderRight.text) ?? 0,
        axis: int.tryParse(axisRight.text) ?? 0,
        addition: 0,
        pd: 0,
      ),
      leftEye: EyeMeasurement(
        sphere: double.tryParse(sphereLeft.text) ?? 0,
        cylinder: double.tryParse(cylinderLeft.text) ?? 0,
        axis: int.tryParse(axisLeft.text) ?? 0,
        addition: 0,
        pd: 0,
      ),
      updatedAt: now,
      doctor: doctor.text.trim().isEmpty ? null : doctor.text.trim(),
      notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
      reminderMonths: reminderMonths,
    );
  }

  void dispose() {
    for (final c in allControllers) {
      c.dispose();
    }
  }
}
