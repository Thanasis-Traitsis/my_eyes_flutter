import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/presentation/shared/widgets/bottom_navbar.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class CustomScreen extends StatelessWidget {
  const CustomScreen({
    super.key,
    required this.child,
    this.withPadding = true,
    this.bigTitle,
    this.regularTitle,
    this.subtitle,
    this.suffixButtons = const [],
    this.prefixButtons = const [],
    this.includeBottomSpacing = false,
  });

  final Widget child;
  final bool withPadding;
  final String? bigTitle;
  final String? regularTitle;
  final String? subtitle;
  final List<IconButton> suffixButtons;
  final List<IconButton> prefixButtons;
  final bool includeBottomSpacing;

  const CustomScreen.withBottomNavbar({
    super.key,
    required this.child,
    this.withPadding = true,
    this.bigTitle,
    this.regularTitle,
    this.subtitle,
    this.suffixButtons = const [],
    this.prefixButtons = const [],
    this.includeBottomSpacing = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: .all(AppSpacing.screenPadding),
                    child: Column(
                      children: [
                        child,
                        if (includeBottomSpacing)
                          Opacity(
                            opacity: 0,
                            child: Padding(
                              padding: const .symmetric(
                                vertical: AppSpacing.spacingM,
                              ),
                              child: BottomNavbar(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final hasTitles = [
      bigTitle,
      regularTitle,
      subtitle,
    ].any((text) => text != null);

    return Container(
      color:
          Theme.of(context).appBarTheme.backgroundColor ??
          Theme.of(context).colorScheme.surface,
      padding: const .all(AppSpacing.screenPadding),
      child: Row(
        spacing: AppSpacing.spacingS,
        crossAxisAlignment: .center,
        children: [
          ...prefixButtons,
          if (hasTitles)
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  if (bigTitle case final title?)
                    CustomText(
                      text: title,
                      textType: CustomTextType.bigHeading,
                    ),
                  if (regularTitle case final title?)
                    CustomText(
                      text: title,
                      textType: CustomTextType.smallHeading,
                    ),
                  if (subtitle case final title?)
                    CustomText(
                      text: title,
                      textType: CustomTextType.regularBody,
                    ),
                ],
              ),
            ),
          ...suffixButtons,
        ],
      ),
    );
  }
}
