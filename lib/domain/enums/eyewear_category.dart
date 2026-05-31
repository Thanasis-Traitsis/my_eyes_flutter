enum EyewearCategory {
  nearSightedGlasses,
  farSightedGlasses,
  sunglasses,
  contactLenses,
  readingGlasses,
  sportGlasses,
  blueLight;

  String get label => switch (this) {
    EyewearCategory.nearSightedGlasses => 'Near-Sighted Glasses',
    EyewearCategory.farSightedGlasses => 'Far-Sighted Glasses',
    EyewearCategory.sunglasses => 'Sunglasses',
    EyewearCategory.contactLenses => 'Contact Lenses',
    EyewearCategory.readingGlasses => 'Reading Glasses',
    EyewearCategory.sportGlasses => 'Sport Glasses',
    EyewearCategory.blueLight => 'Blue Light Glasses',
  };

  List<String> get eyewearOptions => switch (this) {
    EyewearCategory.nearSightedGlasses => ['near_1', 'near_2', 'near_3'],
    EyewearCategory.farSightedGlasses => ['far_1', 'far_2', 'far_3'],
    EyewearCategory.sunglasses => ['sun_1', 'sun_2', 'sun_3'],
    EyewearCategory.contactLenses => ['contact_1'],
    EyewearCategory.readingGlasses => ['reading_1', 'reading_2'],
    EyewearCategory.sportGlasses => ['sport_1', 'sport_2'],
    EyewearCategory.blueLight => ['blue_1', 'blue_2'],
  };

  List<String> get imagePaths =>
      eyewearOptions.map((name) => 'assets/eyewear/$name.png').toList();
}
