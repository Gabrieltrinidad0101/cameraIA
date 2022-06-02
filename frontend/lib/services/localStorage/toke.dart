import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class LocalSecureDBToken {
  static Future<void> save(String token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<String?> get() async {
    String? token = await storage.read(key: "token");
    return token;
  }

  static Future<void> delete() async {
    await storage.delete(key: "token");
  }
}
