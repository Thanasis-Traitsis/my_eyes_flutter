import 'package:my_eyes/core/constants/app_strings.dart';

enum TestFilterKey {
  eyewearId;

  String get label => switch (this) {
    TestFilterKey.eyewearId => AppStrings.testHistoryFilterSectionEyewear,
  };
}
