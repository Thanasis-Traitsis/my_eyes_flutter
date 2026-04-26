import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/presentation/profile/controller/edit_profile_form_controller.dart';
import 'package:my_eyes/presentation/profile/widgets/edit_profile/eye_fields.dart';

class PrescriptionSection extends StatelessWidget {
  const PrescriptionSection({
    super.key,
    required this.formController,
    required this.onValidationChanged,
  });

  final EditProfileFormController formController;
  final void Function(TextEditingController controller, bool isValid)
  onValidationChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: AppSpacing.spacingM,
      children: [
        EyeFields(
          label: AppStrings.prescriptionOdRight,
          formController: formController,
          sphereController: formController.sphereRight,
          cylinderController: formController.cylinderRight,
          axisController: formController.axisRight,
          onValidationChanged: onValidationChanged,
        ),
        EyeFields(
          label: AppStrings.prescriptionOsLeft,
          formController: formController,
          sphereController: formController.sphereLeft,
          cylinderController: formController.cylinderLeft,
          axisController: formController.axisLeft,
          onValidationChanged: onValidationChanged,
        ),
      ],
    );
  }
}
