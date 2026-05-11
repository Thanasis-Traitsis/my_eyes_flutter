import 'package:flutter/material.dart';

class AppKeys {
  AppKeys._();

  static const String themeModeKey = 'theme_mode';

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static const String hiveBoxPrescriptions = 'prescriptions';
  static const String hiveBoxProfile = 'profile';
  static const String hiveBoxEyewear = 'eyewear';

  static const String hiveProfileRecordKey = 'profile';
}
