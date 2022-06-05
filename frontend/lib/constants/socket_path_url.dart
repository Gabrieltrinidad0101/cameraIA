import 'package:frontend/services/localSecureStorage/toke.dart';
import './ip.dart';

getSocketUrl() async {
  final String? token = await LocalSecureDBToken.get();
  return "http://$ip:8080/camera?token=$token";
}
