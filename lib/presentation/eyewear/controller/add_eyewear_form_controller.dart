import 'package:flutter/widgets.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';

class AddEyewearFormController {
  AddEyewearFormController([EyewearCategory? category]) {
    name = TextEditingController();
    sphereRight = TextEditingController();
    cylinderRight = TextEditingController();
    axisRight = TextEditingController();
    sphereLeft = TextEditingController();
    cylinderLeft = TextEditingController();
    axisLeft = TextEditingController();
    selectedCategory = category ?? EyewearCategory.nearSightedGlasses;
    selectedOptionIndex = 0;
  }

  AddEyewearFormController.fromItem(EyewearItem item) {
    final rx = item.prescription;
    name = TextEditingController(text: item.name);
    sphereRight = TextEditingController(
      text: rx?.rightEye.sphere.toString() ?? '',
    );
    cylinderRight = TextEditingController(
      text: rx?.rightEye.cylinder.toString() ?? '',
    );
    axisRight = TextEditingController(text: rx?.rightEye.axis.toString() ?? '');
    sphereLeft = TextEditingController(
      text: rx?.leftEye.sphere.toString() ?? '',
    );
    cylinderLeft = TextEditingController(
      text: rx?.leftEye.cylinder.toString() ?? '',
    );
    axisLeft = TextEditingController(text: rx?.leftEye.axis.toString() ?? '');
    selectedCategory = item.category;
    selectedOptionIndex = item.selectedOptionIndex;
  }

  late final TextEditingController name;
  late final TextEditingController sphereRight;
  late final TextEditingController cylinderRight;
  late final TextEditingController axisRight;
  late final TextEditingController sphereLeft;
  late final TextEditingController cylinderLeft;
  late final TextEditingController axisLeft;

  late EyewearCategory selectedCategory;
  late int selectedOptionIndex;

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

  /// Builds the [EyewearItem] from the current form state.
  /// Pass [existing] when editing so the original [id] is preserved.
  EyewearItem buildItem({EyewearItem? existing}) {
    final now = DateTime.now();

    Prescription? prescription;
    if (hasPrescriptionData) {
      prescription = Prescription(
        id: existing?.prescription?.id ?? 'rx-${now.millisecondsSinceEpoch}',
        label: name.text.trim(),
        issueDate: existing?.prescription?.issueDate ?? now,
        rightEye: EyeMeasurement(
          sphere: double.tryParse(sphereRight.text) ?? 0,
          cylinder: double.tryParse(cylinderRight.text) ?? 0,
          axis: int.tryParse(axisRight.text) ?? 0,
          addition: existing?.prescription?.rightEye.addition ?? 0,
          pd: existing?.prescription?.rightEye.pd ?? 0,
        ),
        leftEye: EyeMeasurement(
          sphere: double.tryParse(sphereLeft.text) ?? 0,
          cylinder: double.tryParse(cylinderLeft.text) ?? 0,
          axis: int.tryParse(axisLeft.text) ?? 0,
          addition: existing?.prescription?.leftEye.addition ?? 0,
          pd: existing?.prescription?.leftEye.pd ?? 0,
        ),
        updatedAt: now,
      );
    }

    return EyewearItem(
      id: existing?.id ?? 'eyewear-${now.millisecondsSinceEpoch}',
      name: name.text.trim(),
      category: selectedCategory,
      updatedAt: now,
      selectedOptionIndex: selectedOptionIndex,
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
