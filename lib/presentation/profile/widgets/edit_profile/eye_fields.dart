import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/validators/prescription_validator.dart';
import 'package:my_eyes/presentation/profile/controller/edit_profile_form_controller.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/validated_text_field.dart';

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
    return Column(
      crossAxisAlignment: .start,
      spacing: AppSpacing.spacingS,
      children: [
        CustomText(text: "$label *", textType: CustomTextType.regularBody),
        Row(
          spacing: AppSpacing.spacingM,
          children: [
            Expanded(
              child: ValidatedTextField(
                controller: sphereController,
                validator: const SphereValidator(),
                hintText: 'Sphere',
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                onValidationChanged: (isValid) =>
                    onValidationChanged(sphereController, isValid),
              ),
            ),
            Expanded(
              child: ValidatedTextField(
                controller: cylinderController,
                validator: const CylinderValidator(),
                hintText: 'Cylinder',
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                onValidationChanged: (isValid) =>
                    onValidationChanged(cylinderController, isValid),
              ),
            ),
            Expanded(
              child: ValidatedTextField(
                controller: axisController,
                validator: const AxisValidator(),
                hintText: 'Axis',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                onValidationChanged: (isValid) =>
                    onValidationChanged(axisController, isValid),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
