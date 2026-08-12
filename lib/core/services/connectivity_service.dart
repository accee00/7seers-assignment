import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  final InternetConnection _internetConnection = InternetConnection();

  Stream<bool> get onConnectivityChanged {
    return _internetConnection.onStatusChange.map(
      (status) => status == InternetStatus.connected,
    );
  }

  Future<bool> get hasConnection => _internetConnection.hasInternetAccess;
}
