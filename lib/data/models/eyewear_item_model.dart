import 'package:hive_ce/hive.dart';
import 'package:my_eyes/data/models/prescription_model.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/enums/eyewear_category.dart';

part 'eyewear_item_model.g.dart';

@HiveType(typeId: 3)
class EyewearItemModel extends HiveObject {
  EyewearItemModel({
    required this.id,
    required this.name,
    required this.categoryIndex,
    required this.updatedAt,
    this.prescription,
    this.pendingSync = true,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int categoryIndex;

  @HiveField(3)
  DateTime updatedAt;

  @HiveField(4)
  PrescriptionModel? prescription;

  @HiveField(5)
  bool pendingSync;

  EyewearItem toEntity() => EyewearItem(
    id: id,
    name: name,
    category: EyewearCategory.values[categoryIndex],
    updatedAt: updatedAt,
    prescription: prescription?.toEntity(),
  );

  factory EyewearItemModel.fromEntity(EyewearItem item) => EyewearItemModel(
    id: item.id,
    name: item.name,
    categoryIndex: item.category.index,
    updatedAt: item.updatedAt,
    prescription: item.prescription != null
        ? PrescriptionModel.fromEntity(item.prescription!)
        : null,
    pendingSync: true,
  );
}
