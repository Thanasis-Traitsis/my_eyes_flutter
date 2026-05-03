import 'package:flutter/material.dart';
import 'package:my_eyes/core/router/app_routes.dart';
import 'package:my_eyes/presentation/eyewear/screens/eyewear_screen.dart';
import 'package:my_eyes/presentation/home/screens/home_screen.dart';
import 'package:my_eyes/presentation/notifications/screens/notifications_screen.dart';
import 'package:my_eyes/presentation/profile/screens/edit_profile_screen.dart';
import 'package:my_eyes/presentation/profile/screens/profile_screen.dart';
import 'package:my_eyes/presentation/settings/screens/settings_screen.dart';

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
    builder: (_) => const Placeholder(),
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

  static final eyewearDetail = PageInfo(
    path: ':id',
    name: 'eyewearDetail',
    title: 'Eyewear Detail',
    builder: (_) => const Placeholder(),
  );

  static final eyewearNew = PageInfo(
    path: 'new',
    name: 'eyewearNew',
    title: 'Add Eyewear',
    builder: (_) => const Placeholder(),
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

  static final lensNew = PageInfo(
    path: AppRoutes.lensNew,
    name: 'lensNew',
    title: 'Add Lens',
    builder: (_) => const Placeholder(),
  );

  static final lensDetail = PageInfo(
    path: AppRoutes.lensDetail,
    name: 'lensDetail',
    title: 'Lens Detail',
    builder: (_) => const Placeholder(),
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
