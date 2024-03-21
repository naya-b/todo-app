import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  //عملناه ابستراكت لانو مع الايام ممكن الباكج تنضرب فاا منعمل impl لفيرها
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected =>
      connectionChecker.hasConnection; // رح تعيد true اذا في نت بالجهاز
}
