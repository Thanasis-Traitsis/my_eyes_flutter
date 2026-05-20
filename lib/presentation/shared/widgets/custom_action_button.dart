import 'package:flutter/material.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isActive = true,
    this.isPrimary = false,
  });

  final String buttonText;
  final VoidCallback onPressed;
  final bool isActive;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: isPrimary
          ? OutlinedButton.styleFrom(
              foregroundColor: context.colors.white,
              backgroundColor: context.colors.primary,
            )
          : null,
      onPressed: isActive ? onPressed : null,
      child: Text(buttonText.toUpperCase()),
    );
  }
}
