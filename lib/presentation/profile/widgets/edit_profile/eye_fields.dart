import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/presentation/profile/controller/edit_profile_form_controller.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/prescription_eye_field.dart';

class EyeFields extends StatelessWidget {
  const EyeFields({
    super.key,
    required this.label,
    required this.formController,
    required this.sphereController,
    required this.cylinderController,
    required this.axisController,
    required this.onValidationChanged,
  });

  final String label;
  final TextEditingController sphereController;
  final TextEditingController cylinderController;
  final TextEditingController axisController;
  final EditProfileFormController formController;
  final void Function(TextEditingController controller, bool isValid)
  onValidationChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .only(top: AppSpacing.spacingM),
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSpacing.spacingS,
        children: [
          CustomText(text: "$label *", textType: CustomTextType.regularBody),
          Row(
            spacing: AppSpacing.spacingM,
            children: [
              PrescriptionField(
                field: PrescriptionEyeField.sphere,
                controller: sphereController,
                isOptional: false,
                onValidationChanged: onValidationChanged,
              ),
              PrescriptionField(
                field: PrescriptionEyeField.cylinder,
                controller: cylinderController,
                isOptional: false,
                onValidationChanged: onValidationChanged,
              ),
              PrescriptionField(
                field: PrescriptionEyeField.axis,
                controller: axisController,
                isOptional: false,
                onValidationChanged: onValidationChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
