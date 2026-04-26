import 'package:equatable/equatable.dart';

class EyeMeasurement extends Equatable {
  const EyeMeasurement({
    required this.sphere,
    required this.cylinder,
    required this.axis,
    required this.addition,
    required this.pd,
  });

  final double sphere; // -30.00 to +30.00, step 0.25
  final double cylinder; // -10.00 to +10.00, step 0.25
  final int axis; // 0–180 degrees
  final double addition; // 0.00 to +4.00, step 0.25
  final double pd; // 40–80 mm, step 0.5

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
