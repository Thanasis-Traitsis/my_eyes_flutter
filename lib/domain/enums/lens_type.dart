enum LensType { daily, biWeekly, monthly, quarterly, annual }

extension LensTypeExtension on LensType {
  String get label => switch (this) {
    LensType.daily => 'Daily',
    LensType.biWeekly => 'Bi-Weekly',
    LensType.monthly => 'Monthly',
    LensType.quarterly => 'Quarterly',
    LensType.annual => 'Annual',
  };

  int get totalDays => switch (this) {
    LensType.daily => 1,
    LensType.biWeekly => 14,
    LensType.monthly => 30,
    LensType.quarterly => 90,
    LensType.annual => 365,
  };
}
