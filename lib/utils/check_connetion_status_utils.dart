import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnectionStatusUtils {
  static Future<bool> checkConnectionStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
