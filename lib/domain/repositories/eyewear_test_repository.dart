import 'package:my_eyes/domain/entities/eyewear_test.dart';

abstract class EyewearTestRepository {
  Future<List<EyewearTest>> getTests({String? eyewearId});
  Future<void> saveTest(EyewearTest test);
}
