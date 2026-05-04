class AppStrings {
  AppStrings._();

  static const String appName = 'My Eyes';
  static const String appFont = 'Advent Pro';

  static const String devThemeLoadError = 'ThemeCubit: failed to load theme';
  static const String devThemeSaveError = 'ThemeCubit: failed to save theme';

  static const String navHome = 'Home';
  static const String navEyeTest = 'Eye Test';
  static const String navEyewear = 'Eyewear';
  static const String navProfile = 'Profile';

  static const String offlineBanner = 'No internet connection';

  static const String greetingMorning = 'Good Morning';
  static const String greetingAfternoon = 'Good Afternoon';
  static const String greetingEvening = 'Good Evening';

  static const String homeSectionPrescription = 'Current Prescription';
  static const String homeSectionEyewear = 'My Eyewear Collection';
  static const String homeSectionUpcoming = 'Upcoming';
  static const String homeSectionDetails = 'Details';

  static const String homeButtonEdit = 'Edit';
  static const String homeButtonViewAll = 'View All';
  static const String homeButtonAddNew = 'Add New';

  static const String shortcutAddPrescription = 'Add New Prescription';
  static const String shortcutCalendarEvents = 'Calendar Events';
  static const String shortcutPrescriptionHistory = 'Prescription History';
  static const String shortcutAddLenses = 'Add New Lenses';

  static const String eyewearCarouselCardButtonEdit = 'edit';
  static const String eyewearCarouselCardDetails = 'details';
  static const String eyewearFloatingButtonText = 'add new';

  static const String profileSectionInsight = 'Profile Insight';
  static const String profileSectionPrescription = 'Current Prescription';
  static const String profileLabelNickname = 'Nickname';
  static const String profileLabelLensType = 'Lens Type';
  static const String profileLabelLensesRemaining = 'Lenses Remaining';
  static const String profileLabelCurrentLens = 'Current Lens';
  static const String profileStatDaysLeft = 'Days Left';
  static const String profileStatTests = 'Tests';
  static const String profileStatGlasses = 'Glasses';
  static const String profileButtonEdit = 'Edit';
  static const String profileButtonSave = 'Save';
  static const String profileLabelEmail = 'Email';
  static const String profileButtonEditImage = 'edit image';
  static const String profileEditSectionPersonalDetails = 'Personal Details';
  static const String profileEditSectionCurrentPrescription =
      'Current Prescription';

  static const String validatorInvalidUsernameEmpty =
      'Nickname cannot be empty';
  static String validatorInvalidUsernameShort(int minLength) =>
      'Nickname must be at least $minLength characters';
  static String validatorInvalidUsernameLong(int maxLength) =>
      'Nickname cannot exceed $maxLength characters';
  static const String validatorInvalidEmailEmpty = 'Email cannot be empty';
  static const String validatorInvalidEmailValue =
      'Enter a valid email address';
  static const String validatorInvalidPrescriptionOnlyNum = 'Must be a number';
  static const String validatorInvalidPrescriptionSphereValue =
      'Sphere must be between -30 and +30';
  static const String validatorInvalidPrescriptionCylinderValue =
      'Cylinder must be between -10 and +10';
  static const String validatorInvalidPrescriptionOnlyWholeNum =
      'Must be a whole number';
  static const String validatorInvalidPrescriptionAxisValue =
      'Axis must be between 0 and 180';

  static const String prescriptionOdRight = 'OD (Right)';
  static const String prescriptionOsLeft = 'OS (Left)';

  static const String eyeLeft = 'left';
  static const String eyeRight = 'right';

  static const String calendarEventLensReplacement = 'Lens replacement';
}
