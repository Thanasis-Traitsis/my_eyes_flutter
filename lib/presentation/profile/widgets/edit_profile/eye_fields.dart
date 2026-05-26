import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/prescription_eye_field.dart';

class EyeFields extends StatefulWidget {
  const EyeFields({
    super.key,
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
  final void Function(TextEditingController controller, bool isValid)
  onValidationChanged;

  @override
  State<EyeFields> createState() => _EyeFieldsState();
}

class _EyeFieldsState extends State<EyeFields> {
  String? _sphereError;
  String? _cylinderError;
  String? _axisError;

  String? get _firstError => _sphereError ?? _cylinderError ?? _axisError;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .only(top: AppSpacing.spacingM),
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSpacing.spacingS,
        children: [
          CustomText(
            text: "${widget.label} *",
            textType: CustomTextType.regularBody,
          ),
          Row(
            spacing: AppSpacing.spacingM,
            children: [
              PrescriptionField(
                field: PrescriptionEyeField.sphere,
                controller: widget.sphereController,
                isOptional: false,
                showInlineError: false,
                onErrorChanged: (e) => setState(() => _sphereError = e),
                onValidationChanged: widget.onValidationChanged,
              ),
              PrescriptionField(
                field: PrescriptionEyeField.cylinder,
                controller: widget.cylinderController,
                isOptional: false,
                showInlineError: false,
                onErrorChanged: (e) => setState(() => _cylinderError = e),
                onValidationChanged: widget.onValidationChanged,
              ),
              PrescriptionField(
                field: PrescriptionEyeField.axis,
                controller: widget.axisController,
                isOptional: false,
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
      ),
    );
  }
}
