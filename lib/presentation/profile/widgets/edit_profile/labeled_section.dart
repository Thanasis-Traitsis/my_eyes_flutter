import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/validators/field_validator.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class LabeledSection extends StatelessWidget {
  const LabeledSection({
    super.key,
    required this.title,
    required this.child,
    this.validator,
  });

  final String title;
  final Widget child;
  final OptionalAwareValidator? validator;

  @override
  Widget build(BuildContext context) {
    final isRequired = validator?.isRequired ?? false;

    return Column(
      crossAxisAlignment: .start,
      spacing: AppSpacing.spacingS,
      children: [
        CustomText(
          text: isRequired ? "${title.toUpperCase()} *" : title.toUpperCase(),
          textType: CustomTextType.smallHeading,
        ),
        child,
      ],
    );
  }
}
