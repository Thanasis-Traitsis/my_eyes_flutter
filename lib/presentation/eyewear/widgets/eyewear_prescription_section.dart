import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
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

class _EyeRow extends StatefulWidget {
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
  State<_EyeRow> createState() => _EyeRowState();
}

class _EyeRowState extends State<_EyeRow> {
  String? _sphereError;
  String? _cylinderError;
  String? _axisError;

  String? get _firstError => _sphereError ?? _cylinderError ?? _axisError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.spacingS,
      children: [
        CustomText(text: widget.label, textType: CustomTextType.regularBody),
        Row(
          spacing: AppSpacing.spacingM,
          children: [
            PrescriptionField(
              field: PrescriptionEyeField.sphere,
              controller: widget.sphereController,
              isOptional: true,
              showInlineError: false,
              onErrorChanged: (e) => setState(() => _sphereError = e),
              onValidationChanged: widget.onValidationChanged,
            ),
            PrescriptionField(
              field: PrescriptionEyeField.cylinder,
              controller: widget.cylinderController,
              isOptional: true,
              showInlineError: false,
              onErrorChanged: (e) => setState(() => _cylinderError = e),
              onValidationChanged: widget.onValidationChanged,
            ),
            PrescriptionField(
              field: PrescriptionEyeField.axis,
              controller: widget.axisController,
              isOptional: true,
              showInlineError: false,
              onErrorChanged: (e) => setState(() => _axisError = e),
              onValidationChanged: widget.onValidationChanged,
            ),
          ],
        ),
        if (_firstError case final error?)
          CustomText(
            text: error,
            textType: CustomTextType.smallBody,
            color: context.colors.error,
          ),
      ],
    );
  }
}
