import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/data/datasources/profile_local_datasource.dart';
import 'package:my_eyes/data/models/user_profile_model.dart';
import 'package:my_eyes/data/repositories/profile_repository_impl.dart';
import 'package:my_eyes/domain/entities/user_profile.dart';

class MockProfileLocalDataSource extends Mock
    implements ProfileLocalDataSource {}

class FakeUserProfileModel extends Fake implements UserProfileModel {}

void main() {
  late MockProfileLocalDataSource mockDataSource;
  late ProfileRepositoryImpl repository;

  final tDate = DateTime(2024, 1, 15);

  final tModel = UserProfileModel(
    id: 'u1',
    username: 'Thanasis',
    email: 'test@test.com',
    updatedAt: tDate,
  );

  final tEntity = UserProfile(
    id: 'u1',
    username: 'Thanasis',
    email: 'test@test.com',
    updatedAt: tDate,
  );

  setUpAll(() => registerFallbackValue(FakeUserProfileModel()));

  setUp(() {
    mockDataSource = MockProfileLocalDataSource();
    repository = ProfileRepositoryImpl(mockDataSource);
  });

  group('getProfile', () {
    test('returns entity when model exists', () async {
      when(() => mockDataSource.get()).thenAnswer((_) async => tModel);

      final result = await repository.getProfile();

      expect(result, equals(tEntity));
    });

    test('returns null when no profile stored', () async {
      when(() => mockDataSource.get()).thenAnswer((_) async => null);

      final result = await repository.getProfile();

      expect(result, isNull);
    });
  });

  group('saveProfile', () {
    test('calls datasource save', () async {
      when(() => mockDataSource.save(any())).thenAnswer((_) async {});

      await repository.saveProfile(tEntity);

      verify(() => mockDataSource.save(any())).called(1);
    });
  });

  group('updateProfile', () {
    test('calls datasource update', () async {
      when(() => mockDataSource.update(any())).thenAnswer((_) async {});

      await repository.updateProfile(tEntity);

      verify(() => mockDataSource.update(any())).called(1);
    });
  });
}
