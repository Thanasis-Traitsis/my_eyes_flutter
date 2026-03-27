import 'package:flutter/material.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';

class CustomText extends StatelessWidget {
  final String text;
  final CustomTextType textType;

  const CustomText({
    super.key,
    required this.text,
    this.textType = CustomTextType.regularBody,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textType.getTextStyle(context));
  }
}
