import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';

class ReminderRow extends StatelessWidget {
  const ReminderRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final int? selected;
  final ValueChanged<int?> onChanged;

  static const _options = [
    (label: AppStrings.prescriptionNewReminderNone, months: null),
    (label: '3M', months: 3),
    (label: '6M', months: 6),
    (label: '1Y', months: 12),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.spacingS,
      children: [
        for (final option in _options)
          _ReminderButton(
            label: option.label,
            isSelected: selected == option.months,
            onTap: () => onChanged(option.months),
          ),
      ],
    );
  }
}

class _ReminderButton extends StatelessWidget {
  const _ReminderButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? AppButton.filled(text: label, onPressed: onTap)
        : AppButton.elevated(text: label, onPressed: onTap);
  }
}
