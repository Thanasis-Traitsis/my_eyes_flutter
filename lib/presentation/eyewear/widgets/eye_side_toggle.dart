import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/eyewear/widgets/toggle_option.dart';

enum EyeSide { left, right }

class EyeSideToggle extends StatelessWidget {
  const EyeSideToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final EyeSide selected;
  final ValueChanged<EyeSide> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .only(top: AppSpacing.spacingM),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: AppBorders.largeBorderRadius,
        border: Border.all(color: context.colors.divider),
      ),
      padding: const EdgeInsets.all(AppSpacing.spacingS),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToggleOption(
            label: AppStrings.eyeLeft,
            isSelected: selected == EyeSide.left,
            onTap: () => onChanged(EyeSide.left),
          ),
          ToggleOption(
            label: AppStrings.eyeRight,
            isSelected: selected == EyeSide.right,
            onTap: () => onChanged(EyeSide.right),
          ),
        ],
      ),
    );
  }
}
