enum ChartDateFilter {
  threeMonths,
  sixMonths,
  oneYear,
  all;

  String get label => switch (this) {
    threeMonths => '3M',
    sixMonths => '6M',
    oneYear => '1Y',
    all => 'ALL',
  };

  DateTime? get cutoff {
    final now = DateTime.now();
    return switch (this) {
      threeMonths => DateTime(now.year, now.month - 3, now.day),
      sixMonths => DateTime(now.year, now.month - 6, now.day),
      oneYear => DateTime(now.year - 1, now.month, now.day),
      all => null,
    };
  }
}
