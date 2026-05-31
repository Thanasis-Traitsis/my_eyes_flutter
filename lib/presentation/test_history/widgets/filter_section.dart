import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/domain/entities/filter_category.dart';
import 'package:my_eyes/domain/enums/test_filter_key.dart';
import 'package:my_eyes/presentation/shared/widgets/app_button.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({
    super.key,
    required this.categories,
    required this.activeFilters,
    required this.onOpenSheet,
    required this.onRemoveFilter,
  });

  final List<FilterCategory> categories;
  final Map<TestFilterKey, Set<String>> activeFilters;
  final VoidCallback onOpenSheet;
  final void Function(TestFilterKey key, String id) onRemoveFilter;

  @override
  Widget build(BuildContext context) {
    final labelById = <String, String>{
      for (final cat in categories)
        for (final opt in cat.options) opt.id: opt.label,
    };

    final activeChips = [
      for (final entry in activeFilters.entries)
        for (final id in entry.value) (key: entry.key, id: id),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: AppSpacing.spacingS,
        children: [
          AppButton.outlined(
            text: AppStrings.testHistoryFilterAll,
            onPressed: onOpenSheet,
            iconAlignment: IconAlignment.end,
            icon: Icons.filter_list,
          ),
          for (final chip in activeChips)
            AppButton.filled(
              text: labelById[chip.id] ?? chip.id,
              onPressed: () => onRemoveFilter(chip.key, chip.id),
              iconAlignment: IconAlignment.end,
              icon: Icons.close,
            ),
        ],
      ),
    );
  }
}
