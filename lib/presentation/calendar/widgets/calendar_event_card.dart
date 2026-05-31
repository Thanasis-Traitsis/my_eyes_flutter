import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/date_extensions.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/domain/entities/calendar_event.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/label_tag.dart';

class CalendarEventCard extends StatelessWidget {
  const CalendarEventCard({
    super.key,
    required this.event,
    this.isPast = false,
    this.isNext = false,
  });

  final CalendarEvent event;
  final bool isPast;
  final bool isNext;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          NavigationService.push(AppPages.calendarEventEdit.path, extra: event),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spacingL),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: AppBorders.largeBorderRadius,
          border: Border.all(
            color: isNext
                ? context.colors.tintMintDark
                : context.colors.tintMintDark.withValues(alpha: 0.6),
            width: isNext
                ? AppBorders.mediumBorderWidth
                : AppBorders.smallBorderWidth,
          ),
        ),
        foregroundDecoration: isPast
            ? BoxDecoration(
                color: context.colors.divider.withValues(alpha: 0.4),
                borderRadius: AppBorders.largeBorderRadius,
              )
            : null,
        child: Row(
          spacing: AppSpacing.spacingM,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                spacing: AppSpacing.spacingM,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isNext)
                    LabelTag(
                      label: AppStrings.calendarEventNextEventTag,
                      greenTag: true,
                    ),
                  CustomText(
                    text: event.date.formattedDate,
                    textType: CustomTextType.smallHeading,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: context.colors.tintMint,
                      borderRadius: AppBorders.extraSmallBorderRadius,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacingM,
                      vertical: AppSpacing.spacingS,
                    ),
                    child: CustomText(
                      text: event.title,
                      color: context.colors.tintMintDark,
                      textType: CustomTextType.smallHeading,
                    ),
                  ),
                  if (event.description != null)
                    CustomText(
                      text: AppStrings.noteLabel(event.description!),
                      textType: CustomTextType.smallBody,
                      color: context.colors.textSecondary,
                    ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: context.colors.textPrimary,
              size: AppSizes.iconSizeL,
            ),
          ],
        ),
      ),
    );
  }
}
