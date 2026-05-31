import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class EmptyEyewearView extends StatelessWidget {
  const EmptyEyewearView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CustomText(text: AppStrings.eyewearEmptyState));
  }
}
