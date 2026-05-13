import 'package:equatable/equatable.dart';

class EyewearTest extends Equatable {
  const EyewearTest({
    required this.id,
    required this.eyewearId,
    required this.score,
    required this.takenAt,
  });

  final String id;
  final String eyewearId;
  final int score;
  final DateTime takenAt;

  @override
  List<Object?> get props => [id, eyewearId, score, takenAt];
}
