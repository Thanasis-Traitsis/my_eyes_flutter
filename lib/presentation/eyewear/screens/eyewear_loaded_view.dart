import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/presentation/eyewear/widgets/eyewear_carousel_card.dart';
import 'package:my_eyes/presentation/eyewear/widgets/test_history_card.dart';
import 'package:my_eyes/presentation/shared/widgets/carousel/custom_carousel.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';

class EyewearLoadedView extends StatefulWidget {
  const EyewearLoadedView({super.key, required this.items});

  final List<EyewearItem> items;

  @override
  State<EyewearLoadedView> createState() => _EyewearLoadedViewState();
}

class _EyewearLoadedViewState extends State<EyewearLoadedView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.spacingM,
      children: [
        CustomCarousel(
          onPageChanged: (index) => setState(() => _currentIndex = index),
          children: [
            for (final item in widget.items) EyewearCarouselCard(item: item),
          ],
        ),
        CustomContainer(
          icon: Icons.history,
          containerTitle: 'test history — ${widget.items[_currentIndex].name}',
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
