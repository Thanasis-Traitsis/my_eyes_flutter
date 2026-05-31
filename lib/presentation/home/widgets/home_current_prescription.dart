import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/utils/prescription_extensions.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/prescription/eye_card.dart';

class HomeCurrentPrescription extends StatelessWidget {
  const HomeCurrentPrescription({super.key, this.latestPrescription});

  final Prescription? latestPrescription;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      buttonText: AppStrings.homeButtonEdit,
      onButtonPressed: latestPrescription != null
          ? () => NavigationService.push(
              AppPages.prescriptionEdit.path,
              extra: latestPrescription,
            )
          : null,
      containerTitle: AppStrings.homeSectionPrescription,
      containerChild: latestPrescription != null
          ? IntrinsicHeight(
              child: Row(
                crossAxisAlignment: .start,
                spacing: AppSpacing.spacingM,
                children: [
                  EyeCard(
                    label: AppStrings.prescriptionOsLeft,
                    value: latestPrescription.formattedLeftOrEmpty,
                  ),
                  EyeCard(
                    label: AppStrings.prescriptionOdRight,
                    value: latestPrescription.formattedRightOrEmpty,
                  ),
                ],
              ),
            )
          : const Center(
              child: CustomText(text: AppStrings.homeSectionPrescriptionEmpty),
            ),
    );
  }
}
