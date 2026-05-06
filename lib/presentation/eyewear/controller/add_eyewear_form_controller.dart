import 'package:flutter/widgets.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';

class AddEyewearFormController {
  AddEyewearFormController() {
    name = TextEditingController();
    sphereRight = TextEditingController();
    cylinderRight = TextEditingController();
    axisRight = TextEditingController();
    sphereLeft = TextEditingController();
    cylinderLeft = TextEditingController();
    axisLeft = TextEditingController();
  }

  late final TextEditingController name;
  late final TextEditingController sphereRight;
  late final TextEditingController cylinderRight;
  late final TextEditingController axisRight;
  late final TextEditingController sphereLeft;
  late final TextEditingController cylinderLeft;
  late final TextEditingController axisLeft;

  EyewearCategory selectedCategory = EyewearCategory.nearSightedGlasses;

  final Map<TextEditingController, bool> _validityMap = {};

  List<TextEditingController> get allControllers => [
    name,
    sphereRight,
    cylinderRight,
    axisRight,
    sphereLeft,
    cylinderLeft,
    axisLeft,
  ];

  List<TextEditingController> get prescriptionControllers => [
    sphereRight,
    cylinderRight,
    axisRight,
    sphereLeft,
    cylinderLeft,
    axisLeft,
  ];

  void setValidity(TextEditingController controller, bool isValid) {
    _validityMap[controller] = isValid;
  }

  bool get isFormValid => _validityMap.values.every((v) => v);

  bool get hasPrescriptionData =>
      prescriptionControllers.any((c) => c.text.trim().isNotEmpty);

  EyewearItem buildItem() {
    final now = DateTime.now();

    Prescription? prescription;
    if (hasPrescriptionData) {
      prescription = Prescription(
        id: 'rx-${now.millisecondsSinceEpoch}',
        label: name.text.trim(),
        issueDate: now,
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
      );
    }

    return EyewearItem(
      id: 'eyewear-${now.millisecondsSinceEpoch}',
      name: name.text.trim(),
      category: selectedCategory,
      updatedAt: now,
      prescription: prescription,
    );
  }

  void dispose() {
    name.dispose();
    sphereRight.dispose();
    cylinderRight.dispose();
    axisRight.dispose();
    sphereLeft.dispose();
    cylinderLeft.dispose();
    axisLeft.dispose();
  }
}
