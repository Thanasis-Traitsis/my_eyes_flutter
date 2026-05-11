import 'package:flutter/material.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';

class CustomText extends StatelessWidget {
  final String text;
  final CustomTextType textType;
  final bool isItalic;
  final Color? color;

  const CustomText({
    super.key,
    required this.text,
    this.textType = CustomTextType.regularBody,
    this.isItalic = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textType.getTextStyle(context, isItalic, color: color),
    );
  }
}
