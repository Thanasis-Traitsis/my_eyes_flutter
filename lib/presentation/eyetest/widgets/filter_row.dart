import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/domain/enums/chart_date_filter.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({super.key, required this.selected, required this.onChanged});

  final ChartDateFilter selected;
  final ValueChanged<ChartDateFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.spacingS,
      children: [
        for (final filter in ChartDateFilter.values)
          Expanded(
            child: filter == selected
                ? AppButton.filled(
                    text: filter.label,
                    onPressed: () => onChanged(filter),
                    size: AppButtonSize.small,
                  )
                : AppButton.textButton(
                    text: filter.label,
                    onPressed: () => onChanged(filter),
                    size: AppButtonSize.small,
                  ),
          ),
      ],
    );
  }
}
