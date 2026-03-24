import 'package:flutter/material.dart';

class AppKeys {
  AppKeys._();

  static const String themeModeKey = 'theme_mode';

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
}
