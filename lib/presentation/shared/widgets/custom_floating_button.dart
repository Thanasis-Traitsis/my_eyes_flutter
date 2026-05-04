import 'package:flutter/material.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
    required this.buttonText,
    this.buttonIcon,
    required this.onTap,
  });

  final String buttonText;
  final IconData? buttonIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return buttonIcon != null
        ? FilledButton.icon(
            iconAlignment: IconAlignment.end,
            onPressed: onTap,
            label: CustomText(
              text: buttonText.toUpperCase(),
              textType: CustomTextType.regularButtonText,
              color: context.colors.white,
            ),
            icon: Icon(buttonIcon),
          )
        : FilledButton(
            onPressed: onTap,
            child: CustomText(
              text: buttonText.toUpperCase(),
              textType: CustomTextType.regularButtonText,
              color: context.colors.white,
            ),
          );
  }
}
