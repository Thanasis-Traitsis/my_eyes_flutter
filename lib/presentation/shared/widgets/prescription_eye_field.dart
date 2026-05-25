import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/validators/field_validator.dart';
import 'package:my_eyes/core/validators/prescription_validator.dart';
import 'package:my_eyes/presentation/shared/widgets/validated_text_field.dart';

enum PrescriptionEyeField { sphere, cylinder, axis }

class PrescriptionField extends StatelessWidget {
  const PrescriptionField({
    super.key,
    required this.field,
    required this.controller,
    required this.isOptional,
    required this.onValidationChanged,
    this.showInlineError = true,
    this.onErrorChanged,
  });

  final PrescriptionEyeField field;
  final TextEditingController controller;
  final bool isOptional;
  final void Function(TextEditingController controller, bool isValid)
  onValidationChanged;
  final bool showInlineError;
  final ValueChanged<String?>? onErrorChanged;

  FieldValidator get _validator => switch (field) {
    PrescriptionEyeField.sphere => SphereValidator(isOptional: isOptional),
    PrescriptionEyeField.cylinder => CylinderValidator(isOptional: isOptional),
    PrescriptionEyeField.axis => AxisValidator(isOptional: isOptional),
  };

  String get _hintText => switch (field) {
    PrescriptionEyeField.sphere => AppStrings.prescriptionSphere,
    PrescriptionEyeField.cylinder => AppStrings.prescriptionCylinder,
    PrescriptionEyeField.axis => AppStrings.prescriptionAxis,
  };

  TextInputType get _keyboardType => switch (field) {
    PrescriptionEyeField.axis => TextInputType.number,
    _ => const TextInputType.numberWithOptions(signed: true, decimal: true),
  };

  List<TextInputFormatter> get _inputFormatters => switch (field) {
    PrescriptionEyeField.axis => [FilteringTextInputFormatter.digitsOnly],
    _ => [],
  };

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValidatedTextField(
        controller: controller,
        validator: _validator,
        hintText: _hintText,
        keyboardType: _keyboardType,
        inputFormatters: _inputFormatters,
        showInlineError: showInlineError,
        onErrorChanged: onErrorChanged,
        onValidationChanged: (isValid) =>
            onValidationChanged(controller, isValid),
      ),
    );
  }
}
