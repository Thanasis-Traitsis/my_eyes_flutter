import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/eyewear/cubit/eyewear_cubit.dart';
import 'package:my_eyes/presentation/shared/widgets/carousel/custom_carousel.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';
import 'package:my_eyes/presentation/shared/widgets/prescription_footer_details.dart';

class HomeEyewearCollection extends StatefulWidget {
  const HomeEyewearCollection({super.key});

  @override
  State<HomeEyewearCollection> createState() => _HomeEyewearCollectionState();
}

class _HomeEyewearCollectionState extends State<HomeEyewearCollection> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EyewearCubit, EyewearState>(
      builder: (context, state) {
        if (state is! EyewearLoaded) return const SizedBox.shrink();

        return CustomContainer(
          buttonText: AppStrings.homeButtonViewAll,
          onButtonPressed: () {
            NavigationService.go(AppPages.eyewear.path);
          },
          containerTitle: AppStrings.homeSectionEyewear,
          containerChild: Container(
            margin: .only(top: AppSpacing.spacingM),
            child: CustomCarousel(
              onPageChanged: (index) => setState(() => _selectedIndex = index),
              children: [
                for (final item in state.items)
                  Container(
                    alignment: Alignment.center,
                    padding: .all(AppSpacing.spacingXL),
                    color: context.colors.white,
                    child: CustomText(
                      text: item.name,
                      textType: CustomTextType.regularHeading,
                    ),
                  ),
              ],
            ),
          ),
          footerTitle: AppStrings.homeSectionDetails,
          footerContent: Column(
            crossAxisAlignment: .start,
            children: [
              PrescriptionFooterDetails(
                prescription: state.items[_selectedIndex].prescription,
              ),
            ],
          ),
        );
      },
    );
  }
}
