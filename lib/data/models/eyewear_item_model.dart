import 'package:hive_ce/hive.dart';
import 'package:my_eyes/data/models/contact_lens_supply_model.dart';
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
    this.selectedOptionIndex = 0,
    this.colorValue = 0xFF9E9EAF,
    this.prescription,
    this.pendingSync = true,
    this.contactLensSupply,
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

  @HiveField(6)
  int selectedOptionIndex;

  @HiveField(7)
  int colorValue;

  @HiveField(8)
  ContactLensSupplyModel? contactLensSupply;

  EyewearItem toEntity() => EyewearItem(
    id: id,
    name: name,
    category: EyewearCategory.values[categoryIndex],
    updatedAt: updatedAt,
    selectedOptionIndex: selectedOptionIndex,
    colorValue: colorValue,
    prescription: prescription?.toEntity(),
    contactLensSupply: contactLensSupply?.toEntity(),
  );

  factory EyewearItemModel.fromEntity(EyewearItem item) => EyewearItemModel(
    id: item.id,
    name: item.name,
    categoryIndex: item.category.index,
    updatedAt: item.updatedAt,
    selectedOptionIndex: item.selectedOptionIndex,
    colorValue: item.colorValue,
    prescription: item.prescription != null
        ? PrescriptionModel.fromEntity(item.prescription!)
        : null,
    pendingSync: true,
    contactLensSupply: item.contactLensSupply != null
        ? ContactLensSupplyModel.fromEntity(item.contactLensSupply!)
        : null,
  );
}
