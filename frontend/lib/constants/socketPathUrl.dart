import 'package:frontend/services/localStorage/toke.dart';
import './ip.dart';

getSocketUrl() async {
  final String? token = await LocalSecureDBToken.get();
  return "http://$ip:8080/camera?token=ace42558c1c311ec81a8b9c262b83047";
}
