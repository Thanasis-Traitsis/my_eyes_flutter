import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';
import 'package:my_eyes/core/constants/app_text_sizes.dart';
import 'package:my_eyes/core/theme/app_theme.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';

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
    this.isError = false,
  }) : _variant = _Variant.filled;

  const AppButton.outlined({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = AppButtonSize.regular,
    this.icon,
    this.iconAlignment = IconAlignment.end,
    this.isError = false,
  }) : _variant = _Variant.outlined;

  const AppButton.textButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = AppButtonSize.regular,
    this.icon,
    this.iconAlignment = IconAlignment.end,
    this.isError = false,
  }) : _variant = _Variant.textButton;

  final String text;
  final VoidCallback? onPressed;
  final AppButtonSize size;
  final IconData? icon;
  final IconAlignment iconAlignment;
  final bool isError;
  final _Variant _variant;

  @override
  Widget build(BuildContext context) {
    final style = _style(context);
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

  ButtonStyle _style(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;

    return ButtonStyle(
      padding: WidgetStatePropertyAll(_padding),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          fontFamily: AppTheme.appFontBody,
          fontSize: _fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      overlayColor: isError
          ? WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return errorColor.withValues(alpha: 0.12);
              }
              if (states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.focused)) {
                return errorColor.withValues(alpha: 0.08);
              }
              return null;
            })
          : null,
      backgroundColor: isError
          ? WidgetStatePropertyAll(context.colors.errorLight)
          : null,
      foregroundColor: isError ? WidgetStatePropertyAll(errorColor) : null,
      side: isError && _variant == _Variant.textButton
          ? WidgetStatePropertyAll(BorderSide(color: errorColor))
          : null,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: size == AppButtonSize.large
              ? AppBorders.smallBorderRadius
              : AppBorders.largeBorderRadius,
        ),
      ),
      minimumSize: WidgetStatePropertyAll(
        size == AppButtonSize.large
            ? const Size(double.infinity, 0)
            : Size.zero,
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

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
