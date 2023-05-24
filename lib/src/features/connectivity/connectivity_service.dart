import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectionStatus { notDetermined, isConnected, isDisconnected }

class ConnectionStatusNotifier extends StateNotifier<ConnectionStatus> {
  ConnectionStatus? lastResult;
  ConnectionStatus? newState;
  ConnectionStatusNotifier() : super(ConnectionStatus.isConnected) {
    if (state == ConnectionStatus.isConnected) {
      lastResult = ConnectionStatus.isConnected;
    } else {
      lastResult = ConnectionStatus.isDisconnected;
    }
    lastResult = ConnectionStatus.notDetermined;
    Connectivity().onConnectivityChanged.listen((event) {
      switch (event) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.vpn:
        case ConnectivityResult.wifi:
          newState = ConnectionStatus.isConnected;
          break;
        case ConnectivityResult.none:
          newState = ConnectionStatus.isDisconnected;
          break;
      }
      if (newState != lastResult) {
        state = newState!;
        lastResult = newState;
      }
    });
  }
}

final connectionStatusProviders = StateNotifierProvider((ref) {
  return ConnectionStatusNotifier();
});
