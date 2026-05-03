import 'package:my_eyes/domain/entities/eyewear_item.dart';

abstract class EyewearRepository {
  Future<List<EyewearItem>> getAll();
  Future<void> save(EyewearItem item);
  Future<void> update(EyewearItem item);
  Future<void> delete(String id);
}
