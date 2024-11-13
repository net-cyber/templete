import 'package:connectivity_plus/connectivity_plus.dart';

class AppConnectivity {
  static Future<bool> connectivity() async {
    final connectionResults = await (Connectivity().checkConnectivity());
    if (connectionResults.contains(ConnectivityResult.mobile) ||
        connectionResults.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }
}
