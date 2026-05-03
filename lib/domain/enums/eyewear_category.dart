enum EyewearCategory {
  nearSightedGlasses,
  farSightedGlasses,
  sunglasses,
  contactLenses,
  readingGlasses,
  sportGlasses,
  blueLight,
}

extension EyewearCategoryExtension on EyewearCategory {
  String get label => switch (this) {
    EyewearCategory.nearSightedGlasses => 'Near-Sighted Glasses',
    EyewearCategory.farSightedGlasses => 'Far-Sighted Glasses',
    EyewearCategory.sunglasses => 'Sunglasses',
    EyewearCategory.contactLenses => 'Contact Lenses',
    EyewearCategory.readingGlasses => 'Reading Glasses',
    EyewearCategory.sportGlasses => 'Sport Glasses',
    EyewearCategory.blueLight => 'Blue Light Glasses',
  };
}
