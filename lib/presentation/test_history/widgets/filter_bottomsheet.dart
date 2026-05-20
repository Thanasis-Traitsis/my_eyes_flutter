import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_bottomsheet.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/test_history/widgets/filter_chip.dart';

Future<Set<String>?> showFilterBottomSheet({
  required BuildContext context,
  required List<EyewearItem> items,
  required Set<String> activeFilters,
}) {
  final draft = Set.of(activeFilters);

  return showModalBottomSheet<Set<String>>(
    context: context,
    isScrollControlled: false,
    builder: (_) => StatefulBuilder(
      builder: (sheetContext, setSheetState) => CustomBottomsheet(
        bottomsheetTitle: AppStrings.testHistoryFilterSheetTitle,
        secondaryButtonText: AppStrings.testHistoryFilterClearAll,
        primaryButtonText: AppStrings.testHistoryFilterApply,
        isPrimaryActive: true,
        primaryOnPressed: () => Navigator.of(sheetContext).pop(draft),
        secondaryOnPressed: () => Navigator.of(sheetContext).pop(<String>{}),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.spacingM,
          children: [
            CustomText(
              text: AppStrings.testHistoryFilterSectionEyewear,
              textType: CustomTextType.smallHeading,
            ),
            Wrap(
              spacing: AppSpacing.spacingS,
              runSpacing: AppSpacing.spacingS,
              children: [
                for (final item in items)
                  BottomsheetFilterChip(
                    label: item.name,
                    isSelected: draft.contains(item.id),
                    onTap: () => setSheetState(() {
                      if (draft.contains(item.id)) {
                        draft.remove(item.id);
                      } else {
                        draft.add(item.id);
                      }
                    }),
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
