import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/theme/custom_text_type.dart';
import 'package:my_eyes/core/utils/date_extensions.dart';
import 'package:my_eyes/core/utils/double_extensions.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/presentation/shared/widgets/custom_text.dart';

class ChartDiagram extends StatelessWidget {
  const ChartDiagram({super.key, required this.items, required this.tests});

  final List<EyewearItem> items;
  final List<EyewearTest> tests;

  @override
  Widget build(BuildContext context) {
    final bars = <LineChartBarData>[];

    for (int i = 0; i < items.length; i++) {
      final eyewear = items[i];
      final eyewearTests =
          tests.where((t) => t.eyewearId == eyewear.id).toList()
            ..sort((a, b) => a.takenAt.compareTo(b.takenAt));

      if (eyewearTests.isEmpty) continue;

      bars.add(
        LineChartBarData(
          spots: eyewearTests
              .map(
                (t) => FlSpot(
                  t.takenAt.millisecondsSinceEpoch.toDouble(),
                  t.score.toDouble(),
                ),
              )
              .toList(),
          color: eyewear.color,
          isCurved: true,
          barWidth: 2,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
        ),
      );
    }

    if (bars.isEmpty) {
      return const Center(child: Text(AppStrings.eyeTestStatisticsEmpty));
    }

    final allTimestamps = bars.expand((b) => b.spots).map((s) => s.x);
    const padding = Duration(days: 10);
    final minX = allTimestamps.reduce(min) - padding.inMilliseconds;
    final maxX = allTimestamps.reduce(max) + padding.inMilliseconds;
    final step = (maxX - minX) / 4;

    return LineChart(
      LineChartData(
        minX: minX,
        maxX: maxX,
        minY: 0,
        maxY: 100,
        lineBarsData: bars,
        clipData: const FlClipData.all(),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: step,
              getTitlesWidget: (value, meta) {
                if (value == meta.min || value == meta.max)
                  return const SizedBox.shrink();

                return SideTitleWidget(
                  meta: meta,
                  child: CustomText(
                    text: value.toChartDate().toChartLabel(),
                    textType: CustomTextType.xSmallBody,
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) => SideTitleWidget(
                meta: meta,
                child: CustomText(
                  text: value.toPercentLabel(),
                  textType: CustomTextType.xSmallBody,
                ),
              ),
            ),
          ),
        ),
        gridData: const FlGridData(show: true),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
