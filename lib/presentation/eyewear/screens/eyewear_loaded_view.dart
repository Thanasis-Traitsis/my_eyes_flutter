import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/presentation/eyewear/widgets/contact_lens_status_container.dart';
import 'package:my_eyes/presentation/eyewear/widgets/eyewear_carousel_card.dart';
import 'package:my_eyes/presentation/shared/widgets/carousel/custom_carousel.dart';
import 'package:my_eyes/presentation/shared/widgets/test_history_container.dart';

class EyewearLoadedView extends StatefulWidget {
  const EyewearLoadedView({super.key, required this.items});

  final List<EyewearItem> items;

  @override
  State<EyewearLoadedView> createState() => _EyewearLoadedViewState();
}

class _EyewearLoadedViewState extends State<EyewearLoadedView> {
  int _currentIndex = 0;

  @override
  void didUpdateWidget(EyewearLoadedView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items.length != oldWidget.items.length) {
      final safeIndex = _currentIndex.clamp(0, widget.items.length - 1);
      if (safeIndex != _currentIndex) {
        setState(() => _currentIndex = safeIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = widget.items[_currentIndex];
    final isContactLens =
        currentItem.category == EyewearCategory.contactLenses &&
        currentItem.contactLensSupply != null;

    return Column(
      spacing: AppSpacing.spacingM,
      children: [
        CustomCarousel(
          onPageChanged: (index) => setState(() => _currentIndex = index),
          children: [
            for (final item in widget.items) EyewearCarouselCard(item: item),
          ],
        ),
        if (isContactLens)
          ContactLensStatusContainer(
            key: ValueKey('lens-status-${currentItem.id}'),
            item: currentItem,
          ),
        TestHistoryContainer(
          key: ValueKey(currentItem.id),
          eyewearId: currentItem.id,
        ),
      ],
    );
  }
}
