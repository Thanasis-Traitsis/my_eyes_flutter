import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/filter_category.dart';
import 'package:my_eyes/domain/enums/test_filter_key.dart';

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
          OutlinedButton.icon(
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.filter_list, size: AppSizes.iconSizeS),
            label: Text(AppStrings.testHistoryFilterAll.toUpperCase()),
            onPressed: onOpenSheet,
          ),
          for (final chip in activeChips)
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: context.colors.white,
                backgroundColor: context.colors.textPrimary,
              ),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.close, size: AppSizes.iconSizeS),
              label: Text(labelById[chip.id] ?? chip.id.toUpperCase()),
              onPressed: () => onRemoveFilter(chip.key, chip.id),
            ),
        ],
      ),
    );
  }
}
