import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_eyes/core/network/connectivity_cubit/connectivity_cubit.dart';
import 'package:my_eyes/core/network/connectivity_service.dart';

class MockConnectivityService extends Mock implements ConnectivityService {}

void main() {
  late MockConnectivityService service;

  setUp(() {
    service = MockConnectivityService();
  });

  ConnectivityCubit buildCubit() => ConnectivityCubit(service);

  group('ConnectivityCubit initial state', () {
    test('defaults to offline', () {
      when(() => service.isConnected()).thenAnswer((_) async => false);
      when(
        () => service.onConnectivityChanged,
      ).thenAnswer((_) => const Stream.empty());

      expect(buildCubit().state.status, ConnectivityStatus.offline);
    });
  });

  group('_init', () {
    blocTest<ConnectivityCubit, ConnectivityState>(
      'emits online when initial check returns true',
      build: () {
        when(() => service.isConnected()).thenAnswer((_) async => true);
        when(
          () => service.onConnectivityChanged,
        ).thenAnswer((_) => const Stream.empty());
        return buildCubit();
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const ConnectivityState(status: ConnectivityStatus.online),
      ],
    );

    blocTest<ConnectivityCubit, ConnectivityState>(
      'emits offline when initial check returns false',
      build: () {
        when(() => service.isConnected()).thenAnswer((_) async => false);
        when(
          () => service.onConnectivityChanged,
        ).thenAnswer((_) => const Stream.empty());
        return buildCubit();
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const ConnectivityState(status: ConnectivityStatus.offline),
      ],
    );

    blocTest<ConnectivityCubit, ConnectivityState>(
      'emits online then offline when stream fires disconnect',
      build: () {
        when(() => service.isConnected()).thenAnswer((_) async => true);
        when(
          () => service.onConnectivityChanged,
        ).thenAnswer((_) => Stream.fromIterable([true, false]));
        return buildCubit();
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const ConnectivityState(status: ConnectivityStatus.online),
        const ConnectivityState(status: ConnectivityStatus.offline),
      ],
    );

    blocTest<ConnectivityCubit, ConnectivityState>(
      'emits offline then online when stream fires reconnect',
      build: () {
        when(() => service.isConnected()).thenAnswer((_) async => false);
        when(
          () => service.onConnectivityChanged,
        ).thenAnswer((_) => Stream.fromIterable([false, true]));
        return buildCubit();
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const ConnectivityState(status: ConnectivityStatus.offline),
        const ConnectivityState(status: ConnectivityStatus.online),
      ],
    );
  });

  group('ConnectivityState helpers', () {
    test('isOnline returns true when status is online', () {
      const state = ConnectivityState(status: ConnectivityStatus.online);
      expect(state.isOnline, isTrue);
    });

    test('isOnline returns false when status is offline', () {
      const state = ConnectivityState(status: ConnectivityStatus.offline);
      expect(state.isOnline, isFalse);
    });
  });
}
