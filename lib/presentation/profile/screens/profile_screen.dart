import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/injection.dart';
import 'package:my_eyes/presentation/profile/cubit/profile_cubit.dart';
import 'package:my_eyes/presentation/profile/widgets/profile_insight.dart';
import 'package:my_eyes/presentation/profile/widgets/profile_summary.dart';
import 'package:my_eyes/presentation/shared/screens/custom_screen.dart';
import 'package:my_eyes/presentation/shared/widgets/shortcut_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const _ProfileScreenContent(),
    );
  }
}

class _ProfileScreenContent extends StatelessWidget {
  const _ProfileScreenContent();

  @override
  Widget build(BuildContext context) {
    return CustomScreen.withBottomNavbar(
      bigTitle: AppPages.profile.title,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) => switch (state) {
          ProfileInitial() ||
          ProfileLoading() => const Center(child: CircularProgressIndicator()),
          ProfileError(:final message) => Center(child: Text(message)),
          ProfileLoaded(:final profile, :final latestPrescription) => Column(
            spacing: AppSpacing.spacingM,
            children: [
              ProfileSummary(
                username: profile.username,
                prescription: latestPrescription,
              ),
              const ProfileInsight(),
              ShortcutCard(
                cardTitle: AppStrings.shortcutCalendarEvents,
                cardSubtitle: '3 upcoming events',
                icon: Icons.calendar_month_outlined,
              ),
              ShortcutCard(
                cardTitle: AppStrings.shortcutPrescriptionHistory,
                icon: Icons.history_outlined,
              ),
            ],
          ),
        },
      ),
    );
  }
}
