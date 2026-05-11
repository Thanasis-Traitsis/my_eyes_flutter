import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:my_eyes/data/models/eye_measurement_model.dart';
import 'package:my_eyes/data/models/eyewear_item_model.dart';
import 'package:my_eyes/data/models/prescription_model.dart';
import 'package:my_eyes/data/models/user_profile_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  _registerAdapters();
}

void _registerAdapters() {
  Hive.registerAdapter(EyeMeasurementModelAdapter());
  Hive.registerAdapter(PrescriptionModelAdapter());
  Hive.registerAdapter(UserProfileModelAdapter());
  Hive.registerAdapter(EyewearItemModelAdapter());
}
