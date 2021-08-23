import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _secureStorage = SecureStorage._internal();

  factory SecureStorage() {
    return _secureStorage;
  }
  SecureStorage._internal();

  Future<bool> tokenInSecureStorage() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: "accessToken");
    //print(value);

    if (value != null) {
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }



  Future<bool> getId() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: "id");
    print(value);

    if (value != null) {
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }



}