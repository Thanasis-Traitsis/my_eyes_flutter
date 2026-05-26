import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/enums/reminder_interval.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';

class ReminderRow extends StatelessWidget {
  const ReminderRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final int? selected;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.spacingS,
      children: [
        _ReminderButton(
          label: AppStrings.prescriptionNewReminderNone,
          isSelected: selected == null,
          onTap: () => onChanged(null),
        ),
        for (final interval in ReminderInterval.values)
          _ReminderButton(
            label: interval.buttonLabel,
            isSelected: selected == interval.months,
            onTap: () => onChanged(interval.months),
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
