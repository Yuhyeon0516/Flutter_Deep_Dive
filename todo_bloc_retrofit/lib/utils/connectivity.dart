import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isNetworkAvailable() async {
  final connectivityResult = await Connectivity().checkConnectivity();

  return connectivityResult.contains(ConnectivityResult.none) ? false : true;
}
