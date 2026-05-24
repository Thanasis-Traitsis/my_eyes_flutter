extension DoubleChartFormat on double {
  String toPercentLabel() => '${toInt()}%';

  DateTime toChartDate() => DateTime.fromMillisecondsSinceEpoch(toInt());
}
