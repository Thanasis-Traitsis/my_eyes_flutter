import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/core/network/connectivity_service.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late MockConnectivity mockConnectivity;
  late ConnectivityService service;

  setUp(() {
    mockConnectivity = MockConnectivity();
    service = ConnectivityService(mockConnectivity);
  });

  group('isConnected', () {
    test('returns true when wifi is available', () async {
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);

      expect(await service.isConnected(), isTrue);
    });

    test('returns true when mobile is available', () async {
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.mobile]);

      expect(await service.isConnected(), isTrue);
    });

    test('returns true when multiple results include a connection', () async {
      when(() => mockConnectivity.checkConnectivity()).thenAnswer(
        (_) async => [ConnectivityResult.none, ConnectivityResult.wifi],
      );

      expect(await service.isConnected(), isTrue);
    });

    test('returns false when only none is returned', () async {
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.none]);

      expect(await service.isConnected(), isFalse);
    });

    test('returns false when results list is empty', () async {
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => []);

      expect(await service.isConnected(), isFalse);
    });
  });

  group('onConnectivityChanged', () {
    test('emits true when wifi result arrives', () {
      when(
        () => mockConnectivity.onConnectivityChanged,
      ).thenAnswer((_) => Stream.value([ConnectivityResult.wifi]));

      expect(service.onConnectivityChanged, emits(true));
    });

    test('emits false when none result arrives', () {
      when(
        () => mockConnectivity.onConnectivityChanged,
      ).thenAnswer((_) => Stream.value([ConnectivityResult.none]));

      expect(service.onConnectivityChanged, emits(false));
    });

    test('emits correct sequence for connect then disconnect', () {
      when(() => mockConnectivity.onConnectivityChanged).thenAnswer(
        (_) => Stream.fromIterable([
          [ConnectivityResult.wifi],
          [ConnectivityResult.none],
        ]),
      );

      expect(service.onConnectivityChanged, emitsInOrder([true, false]));
    });
  });
}
