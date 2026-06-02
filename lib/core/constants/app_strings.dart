class AppStrings {
  AppStrings._();

  static const String appName = 'My Eyes';
  static const String appFontBody = 'PlusJakartaSans';
  static const String appFontHighlight = 'BricolageGrotesque';

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
  static const String homeSectionPrescriptionEmpty =
      'No prescription data found';
  static const String homeSectionEyewear = 'My Eyewear Collection';
  static const String homeSectionUpcoming = 'Upcoming';
  static const String homeSectionUpcomingEmpty = 'No upcoming events.';
  static const String homeSectionDetails = 'Details';
  static const String homeButtonEdit = 'Edit';
  static const String homeButtonViewAll = 'View All';
  static const String homeButtonAddNew = 'Add New';
  static const String shortcutAddPrescription = 'Add New Prescription';
  static const String shortcutCalendarEvents = 'Calendar Events';
  static const String shortcutPrescriptionHistory = 'Prescription History';
  static const String shortcutAddLenses = 'Add New Lenses';

  static const String eyeTestInstructionHeader = 'test instructions';
  static const String eyeTestInstructionDescription =
      'Lorem ipsum dolor sit amet consectetur. Odio vel amet sit id luctus. Et viverra massa commodo diam sapien dignissim lorem sed sem. Condimentum eget pretium nisl pellentesque duis massa. Erat rhoncus massa lectus non sagittis faucibus suspendisse a.';
  static const String eyeTestStep = 'step';
  static const String eyeTestStatisticsHeader = 'test statistics';
  static const String eyeTestStatisticsButtonText = 'all';
  static const String eyeTestStatisticsEmpty = 'No data yet';
  static const String eyeTestChartDateFormat = 'MMM yy';
  static const String eyeTestFloatingButtonText = 'new test';
  static const String eyeTestOnboardingNext = 'Next';
  static const String eyeTestOnboardingStart = 'Start Test';
  static const String eyeTestOnboardingPrevious = 'Previous';
  static const String eyeTestOnboardingExit = 'Exit';
  static const String eyeTestOnboardingSkip = 'Skip';

  static const String eyeTestStep1Label = '1st';
  static const String eyeTestStep1Title = 'Find the right distance';
  static const String eyeTestStep1Description =
      'Hold your device at arm\'s length — about 40 cm away from your eyes. Make sure you are in a well-lit room.';
  static const String eyeTestStep1Short =
      'Hold device ~40 cm away in a well-lit room.';

  static const String eyeTestStep2Label = '2nd';
  static const String eyeTestStep2Title = 'Cover one eye';
  static const String eyeTestStep2Description =
      'Use your hand or a piece of paper to cover one eye at a time. Keep both eyes open to avoid straining.';
  static const String eyeTestStep2Short =
      'Cover one eye at a time with your hand.';

  static const String eyeTestStep3Label = '3rd';
  static const String eyeTestStep3Title = 'Read each line carefully';
  static const String eyeTestStep3Description =
      'Read the letters on screen from top to bottom. Stop when the letters become too blurry to identify.';
  static const String eyeTestStep3Short =
      'Read top to bottom, stop when lines blur.';

  static const String eyewearCarouselCardButtonEdit = 'edit';
  static const String eyewearCarouselCardDetails = 'details';
  static const String eyewearSectionTestHistory = 'Test History';
  static const String eyewearTestHistoryEmpty = 'No tests recorded yet.';
  static const String testHistoryFilterAll = 'All';
  static const String testHistoryFilterSheetTitle = 'Filters';
  static const String testHistoryFilterSectionEyewear = 'Eyewear Collection';
  static const String testHistoryFilterApply = 'Apply';
  static const String testHistoryFilterClearAll = 'Clear All';

  static const String eyewearAddSectionDetails = 'Eyewear Details';
  static const String eyewearAddSectionLensSupply = 'Lens Supply';
  static const String eyewearAddSectionPrescription = 'Prescription';
  static const String eyewearEditActiveLens = 'edit active lens';
  static const String eyewearLensSupplyFieldType = 'Lens Type';
  static const String eyewearLensSupplyFieldQuantity = 'Quantity';
  static const String eyewearLensSupplyFieldQuantityHint = 'e.g. 30';
  static const String eyewearLensSupplyFieldQuantityUnit = 'lenses';
  static const String eyewearLensSupplyFieldExpiry = 'Expiration Date';
  static const String eyewearLensSupplyFieldExpiryHint = 'Select a date';
  static const String eyewearLensStatusTitle = 'Lens Status';
  static const String eyewearLensStatusActive = 'Active';
  static const String eyewearLensStatusInactive = 'Inactive';
  static const String eyewearLensStatusActivateButton = 'Activate Lens';
  static const String eyewearLensStatusDaysRemaining = 'Days Remaining';
  static const String eyewearLensActivateDialogTitle = 'Activate Lens';
  static String eyewearLensActivateDialogDescription(String lensType) =>
      'Start using this $lensType lens? Your remaining count will decrease by 1 and the $lensType countdown will begin.';
  static const String eyewearLensActivateDialogWhenTitle =
      'When did you start using them?';
  static const String eyewearLensActivateOptionToday = 'Right now';
  static const String eyewearLensActivateOptionYesterday = 'Yesterday';
  static const String eyewearLensActivateOptionTwoDays = '2 days ago';
  static const String eyewearLensActivateOptionCustom = 'Choose a date';
  static const String eyewearLensActivateDialogConfirm = 'Activate';
  static const String eyewearLensActivateDialogCancel = 'Cancel';
  static const String eyewearLensUpdateDialogTitle = 'Update Start Date';
  static String eyewearLensUpdateDialogDescription(String lensType) =>
      'Change the start date for your $lensType lens. The countdown will recalculate from the new date.';
  static const String eyewearLensUpdateDialogConfirm = 'Update';
  static const String eyewearLensRemoveDialogTitle = 'Discard Active Lens';
  static const String eyewearLensRemoveDialogBody =
      'Mark this lens as discarded? It will be deactivated and your remaining count will stay the same.';
  static const String eyewearLensRemoveDialogConfirm = 'Discard';
  static const String eyewearLensRemoveDialogCancel = 'Cancel';
  static const String eyewearFieldName = 'Name';
  static const String eyewearFieldNameHint = 'e.g. Daily Frames';
  static const String eyewearFieldColor = 'Colour';
  static const String eyewearHsvPickerDialogTitle = 'Custom colour';
  static const String eyewearHsvPickerDialogDescription =
      'Create your own colour';
  static const String eyewearHsvPickerDialogSave = 'save';
  static const String eyewearHsvPickerDialogCancel = 'cancel';
  static const String eyewearFieldCategory = 'Category';
  static const String eyewearButtonSave = 'Save';
  static const String eyewearPrescriptionOptionalNote =
      'Optional — leave blank if this eyewear has no prescription.';
  static const String eyewearFloatingButtonText = 'add new';

  static const String eyewearDeleteDialogTitle = 'Delete Eyewear';
  static String eyewearDeleteDialogBody(String name) =>
      'Are you sure you want to delete "$name"? This action cannot be undone.';
  static const String eyewearDeleteDialogConfirm = 'Delete';
  static const String eyewearDeleteDialogCancel = 'Cancel';
  static const String eyewearEmptyState = 'No eyewear added yet.';
  static const String prescriptionNoData = 'No data provided';

  static const String profileSectionInsight = 'Profile Insight';
  static const String profileSectionPrescription = 'Current Prescription';
  static const String profileLabelNickname = 'Nickname';
  static const String profileLabelLensType = 'Lens Type';
  static const String profileLabelLensesRemaining = 'Lenses Remaining';
  static const String profileLabelCurrentLens = 'Current Status:';
  static const String profileStatDaysLeft = 'Days Left';
  static const String profileStatTests = 'Tests';
  static const String profileStatGlasses = 'Glasses';
  static const String profileStatLenses = 'Lenses';
  static const String profileButtonEdit = 'Edit';
  static const String profileButtonSave = 'Save';
  static const String profileLabelEmail = 'Email';
  static const String profileButtonEditImage = 'edit image';
  static const String profileNotFoundError = 'No profile found';
  static const String profileAvatarPickerTitle = 'Choose Your Eye Buddy';
  static const String profileAvatarPickerDescription =
      'Pick the character that fits your style most 👀';
  static const String profileAvatarPickerSave = 'Save';
  static const String profileAvatarPickerCancel = 'Cancel';
  static const String profileEditSectionPersonalDetails = 'Personal Details';
  static const String profileShortcutSettings = 'Settings';
  static const String profileEditSectionCurrentPrescription =
      'Current Prescription';
  static String profileShortcutCalendarEventsSubtitle(int events) =>
      '$events upcoming events';

  static const String validatorInvalidUsernameEmpty =
      'Nickname cannot be empty';
  static String validatorInvalidUsernameShort(
    int minLength, {
    String fieldName = 'This field',
  }) => '$fieldName must be at least $minLength characters';
  static String validatorInvalidUsernameLong(
    int maxLength, {
    String fieldName = 'This field',
  }) => '$fieldName cannot exceed $maxLength characters';
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
  static const String prescriptionSphere = 'Sphere';
  static const String prescriptionCylinder = 'Cylinder';
  static const String prescriptionAxis = 'Axis';

  static const String prescriptionNewPrescriptionSection = 'Prescription';
  static const String prescriptionNewReuseButton = 'Use current';
  static const String prescriptionNewDetailsSection = 'Details';
  static const String prescriptionNewIssueDate = 'Issue Date';
  static const String prescriptionNewDateCancelButton = 'dismiss';
  static const String prescriptionNewDateConfirmButton = 'confirm';
  static const String prescriptionNewDoctor = 'Doctor / Hospital';
  static const String prescriptionNewDoctorHint = 'e.g. Dr. Smith';
  static const String prescriptionNewNotes = 'Notes';
  static const String prescriptionNewNotesHint = 'Additional notes...';
  static const String prescriptionNewReminder = 'Recheck Reminder';
  static const String prescriptionNewReminderNone = 'None';
  static const String prescriptionNewSave = 'Save';
  static const String eyewearVisualSelectorHint =
      'Pick the frame style that best matches your eyewear';

  static const String eyeLeft = 'left';
  static const String eyeRight = 'right';
  static String noteLabel(String note) => 'Note: $note';

  static const String calendarEventLensReplacement = 'Lens replacement';

  static const String prescriptionHistoryTitle = 'Prescription History';
  static const String prescriptionHistoryEmpty =
      'No prescriptions recorded yet.';
  static const String prescriptionHistoryCurrentTag = 'current';

  static const String calendarEventsHistoryTitle = 'Calendar Events';

  static const String calendarSectionUpcoming = 'Upcoming';
  static const String calendarSectionPrevious = 'Previous';
  static const String calendarUpcomingEmpty = 'No upcoming events.';
  static const String calendarEventNextEventTag = 'upcoming';

  static const String calendarEventAddSectionDetails = 'Event Details';
  static const String calendarEventFieldTitle = 'Title';
  static const String calendarEventFieldTitleHint = 'e.g. Eye Exam';
  static const String calendarEventFieldDate = 'Date';
  static const String calendarEventFieldNotes = 'Notes';
  static const String calendarEventFieldNotesHint = 'Additional notes...';
  static const String calendarEventButtonSave = 'Save';
  static const String calendarEventDeleteDialogTitle = 'Delete Event';
  static String calendarEventDeleteDialogBody(String title) =>
      'Are you sure you want to delete "$title"? This action cannot be undone.';
  static const String calendarEventDeleteDialogConfirm = 'Delete';
  static const String calendarEventDeleteDialogCancel = 'Cancel';
  static String contactLensType(String type) => 'Lens Type: $type';
  static String contactLensSupplyQuantity(int quantity) =>
      'Quantity: $quantity lenses';
  static const String contactLensButtonRemove = 'remove';
  static const String contactLensButtonUpdate = 'update';
}
