import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_borders.dart';
import 'package:my_eyes/core/constants/app_sizes.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';

class ColorTile extends StatelessWidget {
  const ColorTile({
    super.key,
    required Color this.color,
    required this.isSelected,
    required this.onTap,
  }) : _isCustom = false;

  const ColorTile.custom({super.key, this.color, required this.onTap})
    : isSelected = false,
      _isCustom = true;

  final Color? color;
  final bool isSelected;
  final bool _isCustom;
  final VoidCallback onTap;

  static const double _size = AppSizes.minTouchableArea * .8;

  bool get _isActive => _isCustom ? color != null : isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: _isCustom ? (color ?? context.colors.surface) : color,
          borderRadius: AppBorders.smallBorderRadius,
          border: _border(context),
        ),
        child: _child(context),
      ),
    );
  }

  Border? _border(BuildContext context) {
    if (_isCustom) {
      return Border.all(
        color: _isActive ? context.colors.textPrimary : context.colors.divider,
        width: _isActive
            ? AppBorders.mediumBorderWidth
            : AppBorders.smallBorderWidth,
      );
    }
    return isSelected
        ? Border.all(
            color: context.colors.textPrimary,
            width: AppBorders.mediumBorderWidth,
          )
        : null;
  }

  Widget? _child(BuildContext context) {
    if (_isCustom) {
      return Icon(
        Icons.colorize,
        size: AppSizes.iconSizeS,
        color: _isActive ? Colors.white : context.colors.textHint,
      );
    }
    return isSelected
        ? Icon(
            Icons.check,
            color: context.colors.white,
            size: AppSizes.iconSizeS,
          )
        : null;
  }
}
