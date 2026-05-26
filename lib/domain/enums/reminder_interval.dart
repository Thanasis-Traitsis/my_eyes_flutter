enum ReminderInterval {
  threeMonths(months: 3, buttonLabel: '3M', historyLabel: '3 months'),
  sixMonths(months: 6, buttonLabel: '6M', historyLabel: '6 months'),
  oneYear(months: 12, buttonLabel: '1Y', historyLabel: '1 year');

  const ReminderInterval({
    required this.months,
    required this.buttonLabel,
    required this.historyLabel,
  });

  final int months;
  final String buttonLabel;
  final String historyLabel;

  static ReminderInterval? fromMonths(int? months) => switch (months) {
    3 => ReminderInterval.threeMonths,
    6 => ReminderInterval.sixMonths,
    12 => ReminderInterval.oneYear,
    _ => null,
  };
}
