part of 'connectivity_cubit.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityState extends Equatable {
  const ConnectivityState({this.status = ConnectivityStatus.offline});

  final ConnectivityStatus status;

  bool get isOnline => status == ConnectivityStatus.online;

  ConnectivityState copyWith({ConnectivityStatus? status}) =>
      ConnectivityState(status: status ?? this.status);

  @override
  List<Object> get props => [status];
}
