import 'package:flutter/material.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';

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
    return AppButton.filled(
      iconAlignment: IconAlignment.end,
      icon: buttonIcon,
      text: buttonText,
      onPressed: onTap,
    );
  }
}
