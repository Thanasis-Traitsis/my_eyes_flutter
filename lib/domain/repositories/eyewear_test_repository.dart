import 'package:my_eyes/domain/entities/eyewear_test.dart';

abstract class EyewearTestRepository {
  Future<List<EyewearTest>> getTests({Set<String> eyewearIds = const {}});

  Future<List<EyewearTest>> getTestsPaged({
    Set<String> eyewearIds = const {},
    required int offset,
    required int limit,
  });

  Future<void> saveTest(EyewearTest test);
}
