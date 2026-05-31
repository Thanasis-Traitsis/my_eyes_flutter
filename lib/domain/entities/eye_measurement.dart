import 'package:equatable/equatable.dart';

class EyeMeasurement extends Equatable {
  const EyeMeasurement({
    required this.sphere,
    required this.cylinder,
    required this.axis,
    required this.addition,
    required this.pd,
  });

  final double sphere;
  final double cylinder;
  final int axis;
  final double addition;
  final double pd;

  EyeMeasurement copyWith({
    double? sphere,
    double? cylinder,
    int? axis,
    double? addition,
    double? pd,
  }) {
    return EyeMeasurement(
      sphere: sphere ?? this.sphere,
      cylinder: cylinder ?? this.cylinder,
      axis: axis ?? this.axis,
      addition: addition ?? this.addition,
      pd: pd ?? this.pd,
    );
  }

  @override
  List<Object?> get props => [sphere, cylinder, axis, addition, pd];
}
