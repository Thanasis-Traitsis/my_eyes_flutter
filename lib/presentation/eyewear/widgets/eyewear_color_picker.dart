import 'package:flutter/material.dart';
import 'package:my_eyes/core/theme/app_colors.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/eyewear/widgets/color_picker/color_swatch.dart';
import 'package:my_eyes/presentation/eyewear/widgets/color_picker/hsv_picker_dialog.dart';

List<Color> _presets(AppColors colors) => [
  colors.primary,
  colors.tintPinkDark,
  colors.tintMintDark,
  colors.tintLavenderDark,
  colors.tintPeachDark,
];

class EyewearColorPicker extends StatelessWidget {
  const EyewearColorPicker({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final Color selected;
  final ValueChanged<Color> onChanged;

  bool _isPreset(Color c, AppColors colors) => _presets(colors).contains(c);

  Future<void> _openCustomPicker(BuildContext context) async {
    final picked = await showDialog<Color>(
      context: context,
      builder: (_) => HsvPickerDialog(initial: selected),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final presets = _presets(context.colors);

    return Wrap(
      spacing: AppSpacing.spacingM,
      runSpacing: AppSpacing.spacingM,
      children: [
        for (final color in presets)
          ColorTile(
            color: color,
            isSelected: selected == color,
            onTap: () => onChanged(color),
          ),
        ColorTile.custom(
          color: _isPreset(selected, context.colors) ? null : selected,
          onTap: () => _openCustomPicker(context),
        ),
      ],
    );
  }
}
