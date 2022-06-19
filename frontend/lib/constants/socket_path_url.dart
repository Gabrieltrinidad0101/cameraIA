import 'package:frontend/services/localSecureStorage/toke.dart';
import './server_url.dart';

getSocketUrl() async {
  final String? token = await LocalSecureDBToken.get();
  return "${await serverUrl()}/camera?token=$token";
}
