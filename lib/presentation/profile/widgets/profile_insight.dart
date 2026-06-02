import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';
import 'package:my_eyes/presentation/eyewear/cubit/eyewear_cubit.dart';
import 'package:my_eyes/presentation/profile/widgets/insight_cards_container.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_container.dart';

class ProfileInsight extends StatelessWidget {
  const ProfileInsight({super.key, required this.testCount});

  final int testCount;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EyewearCubit, EyewearState>(
      builder: (context, state) {
        final eyewearLoaded = state is EyewearLoaded ? state : null;
        final lenses = eyewearLoaded?.contactLenses.length ?? 0;
        final glassesCount = eyewearLoaded?.glassesCount ?? 0;

        return CustomContainer(
          icon: Icons.data_saver_off_rounded,
          containerTitle: AppStrings.profileSectionInsight,
          containerChild: InsightCardsContainer(
            testsCount: testCount,
            glassesCount: glassesCount,
            lensesCount: lenses,
          ),
          iconColor: context.colors.primary,
          iconBackgroundColor: context.colors.tintBlue,
        );
      },
    );
  }
}
