import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/presentation/eyewear/widgets/color_picker/color_swatch.dart';
import 'package:my_eyes/presentation/eyewear/widgets/color_picker/hsv_picker_dialog.dart';

const List<Color> _presets = [
  Color(0xFF1E88E5),
  Color(0xFF43A047),
  Color(0xFFE53935),
  Color(0xFFFF8F00),
  Color(0xFF8E24AA),
  Color(0xFF00ACC1),
  Color(0xFFFF6F00),
  Color(0xFF00897B),
  Color(0xFFD81B60),
  Color(0xFF546E7A),
  Color(0xFF6D4C41),
  Color(0xFF9E9EAF),
];

class EyewearColorPicker extends StatelessWidget {
  const EyewearColorPicker({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final Color selected;
  final ValueChanged<Color> onChanged;

  bool _isPreset(Color c) => _presets.contains(c);

  Future<void> _openCustomPicker(BuildContext context) async {
    final picked = await showDialog<Color>(
      context: context,
      builder: (_) => HsvPickerDialog(initial: selected),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.spacingM,
      runSpacing: AppSpacing.spacingM,
      children: [
        for (final color in _presets)
          ColorTile(
            color: color,
            isSelected: selected == color,
            onTap: () => onChanged(color),
          ),
        ColorTile.custom(
          color: _isPreset(selected) ? null : selected,
          onTap: () => _openCustomPicker(context),
        ),
      ],
    );
  }
}
