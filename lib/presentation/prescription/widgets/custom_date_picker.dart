import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: AppBorders.smallBorderRadius,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: context.colors.textPrimary,
            backgroundColor: context.colors.surface,
            side: BorderSide(color: context.colors.textHint),
            shape: RoundedRectangleBorder(
              borderRadius: AppBorders.largeBorderRadius,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacingL,
              vertical: AppSpacing.spacingM,
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
      child: child,
    );
  }
}
