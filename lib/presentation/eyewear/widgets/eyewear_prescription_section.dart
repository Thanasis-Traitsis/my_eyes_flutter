import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/presentation/eyewear/controller/add_eyewear_form_controller.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/prescription_eye_field.dart';

class EyewearPrescriptionSection extends StatelessWidget {
  const EyewearPrescriptionSection({
    super.key,
    required this.formController,
    required this.onValidationChanged,
  });

  final AddEyewearFormController formController;
  final void Function(TextEditingController controller, bool isValid)
  onValidationChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.spacingM,
      children: [
        CustomText(
          text: AppStrings.eyewearPrescriptionOptionalNote,
          textType: CustomTextType.smallBody,
        ),
        _EyeRow(
          label: AppStrings.prescriptionOdRight,
          sphereController: formController.sphereRight,
          cylinderController: formController.cylinderRight,
          axisController: formController.axisRight,
          onValidationChanged: onValidationChanged,
        ),
        _EyeRow(
          label: AppStrings.prescriptionOsLeft,
          sphereController: formController.sphereLeft,
          cylinderController: formController.cylinderLeft,
          axisController: formController.axisLeft,
          onValidationChanged: onValidationChanged,
        ),
      ],
    );
  }
}

class _EyeRow extends StatelessWidget {
  const _EyeRow({
    required this.label,
    required this.sphereController,
    required this.cylinderController,
    required this.axisController,
    required this.onValidationChanged,
  });

  final String label;
  final TextEditingController sphereController;
  final TextEditingController cylinderController;
  final TextEditingController axisController;
  final void Function(TextEditingController, bool) onValidationChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.spacingS,
      children: [
        CustomText(text: label, textType: CustomTextType.regularBody),
        Row(
          spacing: AppSpacing.spacingM,
          children: [
            PrescriptionField(
              field: PrescriptionEyeField.sphere,
              controller: sphereController,
              isOptional: true,
              onValidationChanged: onValidationChanged,
            ),
            PrescriptionField(
              field: PrescriptionEyeField.cylinder,
              controller: cylinderController,
              isOptional: true,
              onValidationChanged: onValidationChanged,
            ),
            PrescriptionField(
              field: PrescriptionEyeField.axis,
              controller: axisController,
              isOptional: true,
              onValidationChanged: onValidationChanged,
            ),
          ],
        ),
      ],
    );
  }
}
