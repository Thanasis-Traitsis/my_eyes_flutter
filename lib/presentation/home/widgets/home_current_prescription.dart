import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/utils/prescription_extensions.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class HomeCurrentPrescription extends StatelessWidget {
  const HomeCurrentPrescription({super.key, this.latestPrescription});

  final Prescription? latestPrescription;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      buttonText: AppStrings.homeButtonEdit,
      onButtonPressed: () {
        NavigationService.push(AppPages.editProfile.path);
      },
      containerTitle: AppStrings.homeSectionPrescription,
      containerChild: latestPrescription != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text:
                      "${AppStrings.prescriptionOdRight}: ${latestPrescription?.formattedRight}",
                ),
                CustomText(
                  text:
                      "${AppStrings.prescriptionOsLeft}: ${latestPrescription?.formattedLeft}",
                ),
              ],
            )
          : const Center(child: Text("No prescription data found")),
    );
  }
}
