import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/core/network/connectivity_service.dart';

part 'connectivity_state.dart';

@singleton
class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit(this._service) : super(const ConnectivityState()) {
    _init();
  }

  final ConnectivityService _service;
  late final StreamSubscription<bool> _subscription;

  Future<void> _init() async {
    final isOnline = await _service.isConnected();
    _emitStatus(isOnline);

    _subscription = _service.onConnectivityChanged.listen(_emitStatus);
  }

  void _emitStatus(bool isOnline) => emit(
    ConnectivityState(
      status: isOnline ? ConnectivityStatus.online : ConnectivityStatus.offline,
    ),
  );

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
