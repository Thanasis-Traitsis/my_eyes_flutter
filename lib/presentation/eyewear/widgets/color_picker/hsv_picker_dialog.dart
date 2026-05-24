import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/presentation/eyewear/widgets/color_picker/slider_row.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_dialog.dart';

class HsvPickerDialog extends StatefulWidget {
  const HsvPickerDialog({super.key, required this.initial});

  final Color initial;

  @override
  State<HsvPickerDialog> createState() => _HsvPickerDialogState();
}

class _HsvPickerDialogState extends State<HsvPickerDialog> {
  late HSVColor _hsv;

  @override
  void initState() {
    super.initState();
    _hsv = HSVColor.fromColor(widget.initial);
  }

  @override
  Widget build(BuildContext context) {
    final color = _hsv.toColor();

    return CustomDialog(
      dialogIcon: Icons.color_lens,
      dialogTitle: AppStrings.eyewearHsvPickerDialogTitle,
      dialogDescription: AppStrings.eyewearHsvPickerDialogDescription,
      dialogBody: Column(
        children: [
          Container(
            height: AppSizes.minTouchableArea,
            decoration: BoxDecoration(
              color: color,
              borderRadius: AppBorders.smallBorderRadius,
            ),
          ),
          SliderRow(
            label: 'H',
            value: _hsv.hue / 360,
            trackGradient: LinearGradient(
              colors: List.generate(
                7,
                (i) => HSVColor.fromAHSV(1, i * 60.0, 1, 1).toColor(),
              ),
            ),
            onChanged: (v) => setState(() => _hsv = _hsv.withHue(v * 360)),
          ),
          SliderRow(
            label: 'S',
            value: _hsv.saturation,
            trackGradient: LinearGradient(
              colors: [
                HSVColor.fromAHSV(1, _hsv.hue, 0, _hsv.value).toColor(),
                HSVColor.fromAHSV(1, _hsv.hue, 1, _hsv.value).toColor(),
              ],
            ),
            onChanged: (v) => setState(() => _hsv = _hsv.withSaturation(v)),
          ),
          SliderRow(
            label: 'B',
            value: _hsv.value,
            trackGradient: LinearGradient(
              colors: [
                Colors.black,
                HSVColor.fromAHSV(1, _hsv.hue, _hsv.saturation, 1).toColor(),
              ],
            ),
            onChanged: (v) => setState(() => _hsv = _hsv.withValue(v)),
          ),
        ],
      ),
      primaryBtnText: AppStrings.eyewearHsvPickerDialogSave,
      primaryBtnAction: () => Navigator.of(context).pop(color),
      secondaryBtnText: AppStrings.eyewearHsvPickerDialogCancel,
      secondaryBtnAction: () => Navigator.of(context).pop(null),
    );
  }
}
