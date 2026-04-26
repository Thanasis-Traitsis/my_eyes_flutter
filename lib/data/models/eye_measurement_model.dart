import 'package:hive_ce/hive.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';

part 'eye_measurement_model.g.dart';

@HiveType(typeId: 1)
class EyeMeasurementModel extends HiveObject {
  EyeMeasurementModel({
    required this.sphere,
    required this.cylinder,
    required this.axis,
    required this.addition,
    required this.pd,
  });

  @HiveField(0)
  double sphere;

  @HiveField(1)
  double cylinder;

  @HiveField(2)
  int axis;

  @HiveField(3)
  double addition;

  @HiveField(4)
  double pd;

  EyeMeasurement toEntity() => EyeMeasurement(
    sphere: sphere,
    cylinder: cylinder,
    axis: axis,
    addition: addition,
    pd: pd,
  );

  factory EyeMeasurementModel.fromEntity(EyeMeasurement e) =>
      EyeMeasurementModel(
        sphere: e.sphere,
        cylinder: e.cylinder,
        axis: e.axis,
        addition: e.addition,
        pd: e.pd,
      );
}
