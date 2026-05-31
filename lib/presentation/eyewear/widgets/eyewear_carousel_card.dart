import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';
import 'package:my_eyes/presentation/eyewear/widgets/eye_side_toggle.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/prescription_footer_details.dart';

class EyewearCarouselCard extends StatefulWidget {
  const EyewearCarouselCard({super.key, required this.item});

  final EyewearItem item;

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
      onButtonPressed: () => NavigationService.pushNamed(
        AppPages.eyewearEdit.name,
        extra: widget.item,
      ),
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
                  fit: StackFit.expand,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.spacingL),
                      decoration: BoxDecoration(
                        borderRadius: AppBorders.largeBorderRadius,
                        border: Border.all(
                          width: AppBorders.smallBorderWidth,
                          color: context.colors.textPrimary.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                      child:
                          widget.item.category == EyewearCategory.contactLenses
                          ? Row(
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    widget.item.category.imagePaths[widget
                                        .item
                                        .selectedOptionIndex],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Expanded(
                                  child: Image.asset(
                                    widget.item.category.imagePaths[widget
                                        .item
                                        .selectedOptionIndex],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            )
                          : Image.asset(
                              widget.item.category.imagePaths[widget
                                  .item
                                  .selectedOptionIndex],
                              fit: BoxFit.contain,
                            ),
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
                                color: context.colors.textPrimary.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: AppSpacing.spacingL,
                      bottom: AppSpacing.spacingM,
                      child: CustomText(
                        text: widget.item.name,
                        textType: CustomTextType.regularHeading,
                        color: widget.item.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      footerTitle: AppStrings.eyewearCarouselCardDetails,
      footerContent: ValueListenableBuilder<EyeSide>(
        valueListenable: _selectedSide,
        builder: (context, side, _) => PrescriptionFooterDetails(
          prescription: prescription,
          selectedSide: side,
        ),
      ),
    );
  }
}
