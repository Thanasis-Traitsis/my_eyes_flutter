import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum AppNotificationChannel {
  lensReminders(
    id: 'lens_reminders',
    name: 'Lens Replacement Reminders',
    description: 'Reminders about your contact lens replacement dates.',
    importance: Importance.high,
  );

  const AppNotificationChannel({
    required this.id,
    required this.name,
    required this.description,
    required this.importance,
  });

  final String id;
  final String name;
  final String description;
  final Importance importance;
}
