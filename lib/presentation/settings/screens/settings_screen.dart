import 'package:flutter/material.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/presentation/shared/screens/full_screen_with_title.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FullScreenWithTitle(
      currentPage: AppPages.settings,
      child: Container(),
    );
  }
}
