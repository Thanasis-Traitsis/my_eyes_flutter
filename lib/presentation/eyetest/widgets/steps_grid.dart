import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_spacing.dart';

class StepsGrid extends StatelessWidget {
  const StepsGrid({super.key, required this.children});

  final List<Widget> children;

  static const _minItemWidth = 100.0;
  static const _spacing = AppSpacing.spacingM;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalSpacing = _spacing * (children.length - 1);
        final itemWidth =
            (constraints.maxWidth - totalSpacing) / children.length;
        final fitsInOneRow = itemWidth >= _minItemWidth;

        if (fitsInOneRow) {
          return _buildRow(children, constraints.maxWidth);
        }

        final firstRow = children.take(2).toList();
        final secondRow = children.skip(2).toList();

        return Column(
          spacing: _spacing,
          children: [
            _buildRow(firstRow, constraints.maxWidth),
            if (secondRow.isNotEmpty)
              _buildRow(secondRow, constraints.maxWidth),
          ],
        );
      },
    );
  }

  Widget _buildRow(List<Widget> items, double totalWidth) {
    return Row(
      spacing: _spacing,
      children: [for (final item in items) Expanded(child: item)],
    );
  }
}
