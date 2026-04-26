import 'package:flutter/widgets.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/entities/user_profile.dart';

class EditProfileFormController {
  EditProfileFormController.fromState({
    required UserProfile profile,
    required Prescription? prescription,
  }) {
    username = TextEditingController(text: profile.username);
    email = TextEditingController(text: profile.email ?? '');

    final rx = prescription;
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
  }

  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController sphereRight;
  late final TextEditingController cylinderRight;
  late final TextEditingController axisRight;
  late final TextEditingController sphereLeft;
  late final TextEditingController cylinderLeft;
  late final TextEditingController axisLeft;
  final Map<TextEditingController, bool> _validityMap = {};

  List<TextEditingController> get allControllers => [
    username,
    email,
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

  Prescription buildUpdatedPrescription(Prescription rx) {
    return rx.copyWith(
      rightEye: EyeMeasurement(
        sphere: double.tryParse(sphereRight.text) ?? rx.rightEye.sphere,
        cylinder: double.tryParse(cylinderRight.text) ?? rx.rightEye.cylinder,
        axis: int.tryParse(axisRight.text) ?? rx.rightEye.axis,
        addition: rx.rightEye.addition,
        pd: rx.rightEye.pd,
      ),
      leftEye: EyeMeasurement(
        sphere: double.tryParse(sphereLeft.text) ?? rx.leftEye.sphere,
        cylinder: double.tryParse(cylinderLeft.text) ?? rx.leftEye.cylinder,
        axis: int.tryParse(axisLeft.text) ?? rx.leftEye.axis,
        addition: rx.leftEye.addition,
        pd: rx.leftEye.pd,
      ),
      updatedAt: DateTime.now(),
    );
  }

  void dispose() {
    username.dispose();
    email.dispose();
    sphereRight.dispose();
    cylinderRight.dispose();
    axisRight.dispose();
    sphereLeft.dispose();
    cylinderLeft.dispose();
    axisLeft.dispose();
  }
}
