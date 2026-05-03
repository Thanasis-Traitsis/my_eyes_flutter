import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/utils/prescription_extensions.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/presentation/eyewear/widgets/eye_side_toggle.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class EyewearCarouselCard extends StatefulWidget {
  const EyewearCarouselCard({
    super.key,
    required this.item,
    required this.onEditPressed,
  });

  final EyewearItem item;
  final VoidCallback onEditPressed;

  @override
  State<EyewearCarouselCard> createState() => _EyewearCarouselCardState();
}

class _EyewearCarouselCardState extends State<EyewearCarouselCard> {
  final _selectedSide = ValueNotifier<EyeSide>(EyeSide.left);

  @override
  void dispose() {
    _selectedSide.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prescription = widget.item.prescription;

    return CustomContainer(
      buttonText: AppStrings.eyewearCarouselCardButtonEdit,
      onButtonPressed: widget.onEditPressed,
      containerTitle: widget.item.category.label,
      containerChild: Column(
        children: [
          ValueListenableBuilder<EyeSide>(
            valueListenable: _selectedSide,
            builder: (context, side, _) => EyeSideToggle(
              selected: side,
              onChanged: (value) => _selectedSide.value = value,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.spacingM),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: AppBorders.largeBorderRadius,
                child: Stack(
                  children: [
                    Container(
                      color: context.colors.white,
                      width: double.infinity,
                      child: Center(child: CustomText(text: widget.item.name)),
                    ),
                    Positioned.fill(
                      child: ValueListenableBuilder<EyeSide>(
                        valueListenable: _selectedSide,
                        builder: (context, side, _) => AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Align(
                            key: ValueKey(side),
                            alignment: side == EyeSide.right
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: FractionallySizedBox(
                              widthFactor: 0.5,
                              heightFactor: 1.0,
                              child: ColoredBox(
                                color: Colors.black.withValues(alpha: 0.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      footerTitle: prescription != null
          ? AppStrings.eyewearCarouselCardDetails
          : null,
      footerContent: prescription != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text:
                      '${AppStrings.prescriptionOdRight}: ${prescription.formattedRight}',
                ),
                CustomText(
                  text:
                      '${AppStrings.prescriptionOsLeft}: ${prescription.formattedLeft}',
                ),
              ],
            )
          : null,
    );
  }
}
