import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_text_sizes.dart';
import 'package:my_eyes/core/theme/app_theme.dart';

enum AppButtonSize { small, regular, large }

enum _Variant { filled, outlined, textButton }

class AppButton extends StatelessWidget {
  const AppButton.filled({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = AppButtonSize.regular,
    this.icon,
    this.iconAlignment = IconAlignment.end,
  }) : _variant = _Variant.filled;

  const AppButton.outlined({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = AppButtonSize.regular,
    this.icon,
    this.iconAlignment = IconAlignment.end,
  }) : _variant = _Variant.outlined;

  const AppButton.textButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = AppButtonSize.regular,
    this.icon,
    this.iconAlignment = IconAlignment.end,
  }) : _variant = _Variant.textButton;

  final String text;
  final VoidCallback? onPressed;
  final AppButtonSize size;
  final IconData? icon;
  final IconAlignment iconAlignment;
  final _Variant _variant;

  @override
  Widget build(BuildContext context) {
    final style = _style();
    final label = Text(text.toUpperCase(), overflow: TextOverflow.ellipsis);

    if (icon case final iconData?) {
      final iconWidget = Icon(iconData, size: AppSizes.iconSizeS);
      return switch (_variant) {
        _Variant.filled => FilledButton.icon(
          onPressed: onPressed,
          style: style,
          iconAlignment: iconAlignment,
          icon: iconWidget,
          label: label,
        ),
        _Variant.outlined => OutlinedButton.icon(
          onPressed: onPressed,
          style: style,
          iconAlignment: iconAlignment,
          icon: iconWidget,
          label: label,
        ),
        _Variant.textButton => TextButton.icon(
          onPressed: onPressed,
          style: style,
          iconAlignment: iconAlignment,
          icon: iconWidget,
          label: label,
        ),
      };
    }

    return switch (_variant) {
      _Variant.filled => FilledButton(
        onPressed: onPressed,
        style: style,
        child: label,
      ),
      _Variant.outlined => OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: label,
      ),
      _Variant.textButton => TextButton(
        onPressed: onPressed,
        style: style,
        child: label,
      ),
    };
  }

  ButtonStyle _style() => ButtonStyle(
    padding: WidgetStatePropertyAll(_padding),
    textStyle: WidgetStatePropertyAll(
      TextStyle(
        fontFamily: AppTheme.appFontBody,
        fontSize: _fontSize,
        fontWeight: FontWeight.bold,
      ),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: size == AppButtonSize.large
            ? AppBorders.smallBorderRadius
            : AppBorders.largeBorderRadius,
      ),
    ),
    minimumSize: WidgetStatePropertyAll(
      size == AppButtonSize.large ? const Size(double.infinity, 0) : Size.zero,
    ),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  EdgeInsets get _padding => switch (size) {
    AppButtonSize.small => const EdgeInsets.symmetric(
      horizontal: AppSpacing.spacingM,
      vertical: AppSpacing.spacingS,
    ),
    AppButtonSize.regular || AppButtonSize.large => const EdgeInsets.symmetric(
      horizontal: AppSpacing.spacingL,
      vertical: AppSpacing.spacingM,
    ),
  };

  double get _fontSize => switch (size) {
    AppButtonSize.small => AppTextSizes.textSizeXS,
    AppButtonSize.regular => AppTextSizes.textSizeS,
    AppButtonSize.large => AppTextSizes.textSizeM,
  };
}
