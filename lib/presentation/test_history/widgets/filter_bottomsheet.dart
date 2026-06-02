import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/domain/entities/filter_category.dart';
import 'package:my_eyes/domain/enums/test_filter_key.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_bottomsheet.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/test_history/widgets/filter_chip.dart';

Future<Map<TestFilterKey, Set<String>>?> showFilterBottomSheet({
  required BuildContext context,
  required List<FilterCategory> categories,
  required Map<TestFilterKey, Set<String>> activeFilters,
}) {
  final draft = <TestFilterKey, Set<String>>{
    for (final e in activeFilters.entries) e.key: Set.of(e.value),
  };

  return showModalBottomSheet<Map<TestFilterKey, Set<String>>>(
    context: context,
    isScrollControlled: true,
    builder: (_) => StatefulBuilder(
      builder: (sheetContext, setSheetState) => CustomBottomsheet(
        bottomsheetTitle: AppStrings.testHistoryFilterSheetTitle,
        secondaryButtonText: AppStrings.testHistoryFilterClearAll,
        primaryButtonText: AppStrings.testHistoryFilterApply,
        isPrimaryActive: true,
        primaryOnPressed: () => Navigator.of(sheetContext).pop(draft),
        secondaryOnPressed: () =>
            Navigator.of(sheetContext).pop(<TestFilterKey, Set<String>>{}),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.spacingL,
          children: [
            for (final category in categories)
              _CategorySection(
                category: category,
                selectedIds: draft[category.key] ?? const {},
                onToggle: (id) => setSheetState(() {
                  final current = draft[category.key] ?? {};
                  if (current.contains(id)) {
                    current.remove(id);
                    if (current.isEmpty) {
                      draft.remove(category.key);
                    } else {
                      draft[category.key] = current;
                    }
                  } else {
                    draft[category.key] = {...current, id};
                  }
                }),
              ),
          ],
        ),
      ),
    ),
  );
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.category,
    required this.selectedIds,
    required this.onToggle,
  });

  final FilterCategory category;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.spacingM,
      children: [
        CustomText(text: category.label, textType: CustomTextType.smallHeading),
        Wrap(
          spacing: AppSpacing.spacingS,
          runSpacing: AppSpacing.spacingS,
          children: [
            for (final option in category.options)
              BottomsheetFilterChip(
                label: option.label,
                isSelected: selectedIds.contains(option.id),
                onTap: () => onToggle(option.id),
              ),
          ],
        ),
      ],
    );
  }
}
