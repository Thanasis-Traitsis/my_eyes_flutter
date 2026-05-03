import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/presentation/eyewear/cubit/eyewear_cubit.dart';
import 'package:my_eyes/presentation/eyewear/widgets/eyewear_carousel_card.dart';
import 'package:my_eyes/presentation/eyewear/widgets/test_history_card.dart';
import 'package:my_eyes/presentation/shared/widgets/carousel/custom_carousel.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';

class EyewearLoadedView extends StatelessWidget {
  const EyewearLoadedView({
    super.key,
    required this.items,
    required this.selectedIndex,
  });

  final List<EyewearItem> items;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.spacingM,
      children: [
        CustomCarousel(
          onPageChanged: (index) =>
              context.read<EyewearCubit>().selectItem(index),
          children: [
            for (final item in items)
              EyewearCarouselCard(item: item, onEditPressed: () {}),
          ],
        ),
        CustomContainer(
          icon: Icons.history,
          containerTitle: 'test history',
          containerChild: Column(
            spacing: AppSpacing.spacingM,
            children: const [
              TestHistoryCard(),
              TestHistoryCard(),
              TestHistoryCard(),
            ],
          ),
        ),
      ],
    );
  }
}
