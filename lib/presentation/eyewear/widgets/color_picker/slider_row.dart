import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/eyewear/widgets/color_picker/gradient_track_shape.dart';

class SliderRow extends StatelessWidget {
  const SliderRow({
    super.key,
    required this.label,
    required this.value,
    required this.trackGradient,
    required this.onChanged,
  });

  final String label;
  final double value;
  final LinearGradient trackGradient;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.spacingM,
      children: [
        SizedBox(
          width: 16,
          child: Text(label, style: const TextStyle(fontSize: 12)),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 12,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              trackShape: GradientTrackShape(gradient: trackGradient),
            ),
            child: Slider(
              value: value,
              onChanged: onChanged,
              activeColor: context.colors.white,
              inactiveColor: context.colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
