import 'package:hive_ce/hive.dart';
import 'package:my_eyes/domain/entities/contact_lens_supply.dart';
import 'package:my_eyes/domain/enums/lens_type.dart';

part 'contact_lens_supply_model.g.dart';

@HiveType(typeId: 6)
class ContactLensSupplyModel extends HiveObject {
  ContactLensSupplyModel({
    required this.lensTypeIndex,
    required this.quantity,
    this.expirationDate,
    this.activatedAt,
  });

  @HiveField(0)
  int lensTypeIndex;

  @HiveField(1)
  int quantity;

  @HiveField(2)
  DateTime? expirationDate;

  @HiveField(3)
  DateTime? activatedAt;

  ContactLensSupply toEntity() => ContactLensSupply(
    lensType: LensType.values[lensTypeIndex],
    quantity: quantity,
    expirationDate: expirationDate,
    activatedAt: activatedAt,
  );

  factory ContactLensSupplyModel.fromEntity(ContactLensSupply supply) =>
      ContactLensSupplyModel(
        lensTypeIndex: supply.lensType.index,
        quantity: supply.quantity,
        expirationDate: supply.expirationDate,
        activatedAt: supply.activatedAt,
      );
}
