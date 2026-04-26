import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_eyes/presentation/home/screens/home_loaded_screen.dart';
import 'package:my_eyes/presentation/profile/cubit/profile_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          ProfileInitial() ||
          ProfileLoading() => const Center(child: CircularProgressIndicator()),
          ProfileError(:final message) => Center(child: Text(message)),
          ProfileLoaded() => HomeLoadedScreen(state: state),
        };
      },
    );
  }
}
