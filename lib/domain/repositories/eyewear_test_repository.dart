import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/domain/enums/test_filter_key.dart';

abstract class EyewearTestRepository {
  Future<List<EyewearTest>> getTests({
    Map<TestFilterKey, Set<String>> filters = const {},
  });

  Future<List<EyewearTest>> getTestsPaged({
    Map<TestFilterKey, Set<String>> filters = const {},
    required int offset,
    required int limit,
  });

  Future<void> saveTest(EyewearTest test);
}
