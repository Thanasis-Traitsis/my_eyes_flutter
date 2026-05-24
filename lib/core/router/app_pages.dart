import 'package:flutter/material.dart';
import 'package:my_eyes/core/router/app_routes.dart';
import 'package:my_eyes/presentation/eyetest/screens/eyetest_screen.dart';
import 'package:my_eyes/presentation/eyewear/screens/add_eyewear_screen.dart';
import 'package:my_eyes/presentation/eyewear/screens/eyewear_screen.dart';
import 'package:my_eyes/presentation/home/screens/home_screen.dart';
import 'package:my_eyes/presentation/newtest/screens/new_test_screen.dart';
import 'package:my_eyes/presentation/notifications/screens/notifications_screen.dart';
import 'package:my_eyes/presentation/profile/screens/edit_profile_screen.dart';
import 'package:my_eyes/presentation/profile/screens/profile_screen.dart';
import 'package:my_eyes/presentation/settings/screens/settings_screen.dart';
import 'package:my_eyes/presentation/test_history/screens/test_history_screen.dart';

class PageInfo {
  final String path;
  final String name;
  final String title;
  final WidgetBuilder builder;

  const PageInfo({
    required this.path,
    required this.name,
    required this.title,
    required this.builder,
  });
}

class AppPages {
  AppPages._();

  static final home = PageInfo(
    path: AppRoutes.home,
    name: 'home',
    title: 'Home',
    builder: (_) => const HomeScreen(),
  );

  static final eyeTest = PageInfo(
    path: AppRoutes.eyeTest,
    name: 'eyeTest',
    title: 'Quick Eye Test',
    builder: (_) => const EyetestScreen(),
  );

  static final eyewear = PageInfo(
    path: AppRoutes.eyewear,
    name: 'eyewear',
    title: 'Eyewear',
    builder: (_) => const EyewearScreen(),
  );

  static final profile = PageInfo(
    path: AppRoutes.profile,
    name: 'profile',
    title: 'Profile',
    builder: (_) => const ProfileScreen(),
  );

  static final editProfile = PageInfo(
    path: AppRoutes.editProfile,
    name: 'editProfile',
    title: 'Edit Profile',
    builder: (_) => const EditProfileScreen(),
  );

  static final notifications = PageInfo(
    path: AppRoutes.notifications,
    name: 'notifications',
    title: 'Notifications',
    builder: (_) => const NotificationsScreen(),
  );

  static final settings = PageInfo(
    path: AppRoutes.settings,
    name: 'settings',
    title: 'Settings',
    builder: (_) => const SettingsScreen(),
  );

  static final eyewearNew = PageInfo(
    path: AppRoutes.eyewearNew,
    name: 'eyewearNew',
    title: 'Add Eyewear',
    builder: (_) => const AddEyewearScreen(),
  );

  static final eyewearEdit = PageInfo(
    path: AppRoutes.eyewearEdit,
    name: 'eyewearEdit',
    title: 'Edit Eyewear',
    builder: (_) => const AddEyewearScreen(),
  );

  static final testHistory = PageInfo(
    path: AppRoutes.testHistory,
    name: 'testHistory',
    title: 'Test History',
    builder: (_) => const TestHistoryScreen(),
  );

  static final newEyeTest = PageInfo(
    path: AppRoutes.newEyeTest,
    name: 'newEyeTest',
    title: 'New Test',
    builder: (_) => const NewTestScreen(),
  );

  static final prescriptionNew = PageInfo(
    path: AppRoutes.prescriptionNew,
    name: 'prescriptionNew',
    title: 'Add Prescription',
    builder: (_) => const Placeholder(),
  );

  static final prescriptionDetail = PageInfo(
    path: AppRoutes.prescriptionDetail,
    name: 'prescriptionDetail',
    title: 'Prescription Detail',
    builder: (_) => const Placeholder(),
  );

  static final prescriptionEdit = PageInfo(
    path: AppRoutes.prescriptionEdit,
    name: 'prescriptionEdit',
    title: 'Edit Prescription',
    builder: (_) => const Placeholder(),
  );

  static final calendarEvents = PageInfo(
    path: AppRoutes.calendarEvents,
    name: 'calendarEvents',
    title: 'Calendar Events',
    builder: (_) => const Placeholder(),
  );
}
