import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/eyewear/cubit/eyewear_cubit.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({
    super.key,
    required this.onTap,
    required this.activeFilters,
    required this.onRemoveFilter,
  });

  final Function(EyewearLoaded state) onTap;

  final Set<String> activeFilters;
  final ValueChanged<String> onRemoveFilter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EyewearCubit, EyewearState>(
      builder: (context, eyewearState) {
        if (eyewearState is! EyewearLoaded || eyewearState.items.isEmpty) {
          return const SizedBox.shrink();
        }

        final itemById = {for (final i in eyewearState.items) i.id: i};

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: AppSpacing.spacingS,
            children: [
              OutlinedButton.icon(
                iconAlignment: IconAlignment.end,
                icon: const Icon(Icons.filter_list, size: AppSizes.iconSizeS),
                label: Text(AppStrings.testHistoryFilterAll.toUpperCase()),
                onPressed: () => onTap(eyewearState),
              ),
              for (final id in activeFilters)
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: context.colors.white,
                    backgroundColor: context.colors.black,
                  ),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.close, size: AppSizes.iconSizeS),
                  label: Text((itemById[id]?.name ?? id).toUpperCase()),
                  onPressed: () => onRemoveFilter(id),
                ),
            ],
          ),
        );
      },
    );
  }
}
