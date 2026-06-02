import 'package:flutter/material.dart';
import 'package:my_eyes/domain/entities/contact_lens_supply.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/domain/enums/lens_type.dart';

class AddEyewearFormController {
  AddEyewearFormController([EyewearCategory? category]) {
    name = TextEditingController();
    lensQuantity = TextEditingController();
    sphereRight = TextEditingController();
    cylinderRight = TextEditingController();
    axisRight = TextEditingController();
    sphereLeft = TextEditingController();
    cylinderLeft = TextEditingController();
    axisLeft = TextEditingController();
    selectedCategory = category ?? EyewearCategory.nearSightedGlasses;
    selectedOptionIndex = 0;
    selectedColor = const Color(0xFF9E9EAF);
    selectedLensType = LensType.daily;
    lensExpirationDate = null;
  }

  AddEyewearFormController.fromItem(EyewearItem item) {
    final rx = item.prescription;
    final supply = item.contactLensSupply;
    name = TextEditingController(text: item.name);
    lensQuantity = TextEditingController(
      text: supply != null ? supply.quantity.toString() : '',
    );
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
    selectedColor = item.color;
    selectedLensType = supply?.lensType ?? LensType.daily;
    lensExpirationDate = supply?.expirationDate;
  }

  late final TextEditingController name;
  late final TextEditingController lensQuantity;
  late final TextEditingController sphereRight;
  late final TextEditingController cylinderRight;
  late final TextEditingController axisRight;
  late final TextEditingController sphereLeft;
  late final TextEditingController cylinderLeft;
  late final TextEditingController axisLeft;

  late EyewearCategory selectedCategory;
  late int selectedOptionIndex;
  late Color selectedColor;
  late LensType selectedLensType;
  DateTime? lensExpirationDate;

  final Map<TextEditingController, bool> _validityMap = {};

  List<TextEditingController> get allControllers => [
    name,
    lensQuantity,
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

  bool get hasLensSupplyData =>
      selectedCategory == EyewearCategory.contactLenses &&
      lensQuantity.text.trim().isNotEmpty;

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

    ContactLensSupply? contactLensSupply;
    if (hasLensSupplyData) {
      contactLensSupply = ContactLensSupply(
        lensType: selectedLensType,
        quantity: int.tryParse(lensQuantity.text.trim()) ?? 0,
        expirationDate: lensExpirationDate,
      );
    }

    return EyewearItem(
      id: existing?.id ?? 'eyewear-${now.millisecondsSinceEpoch}',
      name: name.text.trim(),
      category: selectedCategory,
      updatedAt: now,
      selectedOptionIndex: selectedOptionIndex,
      colorValue: selectedColor.toARGB32(),
      prescription: prescription,
      contactLensSupply: contactLensSupply,
    );
  }

  void dispose() {
    name.dispose();
    lensQuantity.dispose();
    sphereRight.dispose();
    cylinderRight.dispose();
    axisRight.dispose();
    sphereLeft.dispose();
    cylinderLeft.dispose();
    axisLeft.dispose();
  }
}
