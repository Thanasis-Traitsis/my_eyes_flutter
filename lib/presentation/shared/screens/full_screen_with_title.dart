import 'package:flutter/material.dart';
import 'package:my_eyes/core/router/app_pages.dart';
import 'package:my_eyes/core/router/navigation_service.dart';
import 'package:my_eyes/presentation/shared/screens/custom_screen.dart';

class FullScreenWithTitle extends StatelessWidget {
  final PageInfo currentPage;
  final bool withBackButton;
  final Widget child;

  const FullScreenWithTitle({
    super.key,
    required this.currentPage,
    this.withBackButton = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScreen(
      bigTitle: currentPage.title,
      prefixButtons: [
        if (withBackButton)
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              NavigationService.pop();
            },
          ),
      ],
      child: child,
    );
  }
}
