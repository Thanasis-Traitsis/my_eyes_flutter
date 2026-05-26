import 'package:hive_ce/hive.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';

part 'eyewear_test_model.g.dart';

@HiveType(typeId: 4)
class EyewearTestModel extends HiveObject {
  EyewearTestModel({
    required this.id,
    required this.eyewearId,
    required this.score,
    required this.takenAt,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String eyewearId;

  @HiveField(2)
  int score;

  @HiveField(3)
  DateTime takenAt;

  EyewearTest toEntity() =>
      EyewearTest(id: id, eyewearId: eyewearId, score: score, takenAt: takenAt);

  factory EyewearTestModel.fromEntity(EyewearTest test) => EyewearTestModel(
    id: test.id,
    eyewearId: test.eyewearId,
    score: test.score,
    takenAt: test.takenAt,
  );
}
