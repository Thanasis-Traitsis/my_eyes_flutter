import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive_ce/hive.dart';
import 'package:my_eyes/core/constants/app_keys.dart';
import 'package:my_eyes/data/datasources/profile_local_datasource.dart';
import 'package:my_eyes/data/models/user_profile_model.dart';

class MockBox extends Mock implements Box<UserProfileModel> {}

class FakeUserProfileModel extends Fake implements UserProfileModel {}

void main() {
  late MockBox mockBox;
  late HiveProfileLocalDataSource datasource;

  setUpAll(() {
    registerFallbackValue(FakeUserProfileModel());
  });

  final tModel = UserProfileModel(
    id: 'u1',
    username: 'Thanasis',
    email: 'test@test.com',
    updatedAt: DateTime(2024, 1, 15),
  );

  const profileKey = AppKeys.hiveProfileRecordKey;

  setUp(() {
    mockBox = MockBox();
    datasource = HiveProfileLocalDataSource(mockBox);
  });

  group('get', () {
    test('returns model when profile exists', () async {
      when(() => mockBox.get(profileKey)).thenReturn(tModel);

      final result = await datasource.get();

      expect(result, equals(tModel));
      verify(() => mockBox.get(profileKey)).called(1);
    });

    test('returns null when no profile stored', () async {
      when(() => mockBox.get(profileKey)).thenReturn(null);

      final result = await datasource.get();

      expect(result, isNull);
    });
  });

  group('save', () {
    test('calls box.put with the profile key', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await datasource.save(tModel);

      verify(() => mockBox.put(profileKey, tModel)).called(1);
    });
  });

  group('update', () {
    test('calls box.put with the profile key', () async {
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      await datasource.update(tModel);

      verify(() => mockBox.put(profileKey, tModel)).called(1);
    });
  });
}
