import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/presentation/eyewear/cubit/eyewear_cubit.dart';
import 'package:my_eyes/presentation/eyewear/screens/eyewear_empty_view.dart';
import 'package:my_eyes/presentation/eyewear/screens/eyewear_loaded_view.dart';
import 'package:my_eyes/presentation/shared/screens/custom_screen.dart';
import 'package:my_eyes/presentation/shared/widgets/floating_button_section.dart';

class EyewearScreen extends StatelessWidget {
  const EyewearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EyewearCubit, EyewearState>(
      builder: (context, state) {
        return Stack(
          children: [
            CustomScreen.withBottomNavbar(
              bigTitle: AppPages.eyewear.title,
              child: switch (state) {
                EyewearInitial() || EyewearLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                EyewearError(:final message) => Center(child: Text(message)),
                EyewearLoaded(:final items, :final selectedIndex) =>
                  items.isEmpty
                      ? const EmptyEyewearView()
                      : EyewearLoadedView(
                          items: items,
                          selectedIndex: selectedIndex,
                        ),
              },
            ),
            FloatingButtonSection(
              buttonText: AppStrings.eyewearFloatingButtonText,
              buttonIcon: Icons.add,
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}
