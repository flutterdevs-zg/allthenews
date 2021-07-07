import 'package:allthenews/src/data/communication/connection/connection_status_provider.dart';
import 'package:allthenews/src/domain/communication/connection_status.dart';
import 'package:connectivity/connectivity.dart';

class ConnectionStatusLocalProvider implements ConnectionStatusProvider {
  final Connectivity _connectivity;

  ConnectionStatusLocalProvider(this._connectivity);

  @override
  Future<ConnectionStatus> getConnectionStatus() async {
    switch (await _connectivity.checkConnectivity()) {
      case ConnectivityResult.wifi:
        return ConnectionStatus.wifi;
      case ConnectivityResult.mobile:
        return ConnectionStatus.mobile;
      case ConnectivityResult.none:
        return ConnectionStatus.none;
    }
  }
}
