import 'package:allthenews/src/domain/communication/connection_status.dart';

abstract class ConnectionStatusProvider {
  Future<ConnectionStatus> getConnectionStatus();
}
