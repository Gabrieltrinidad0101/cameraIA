import 'package:frontend/services/localStorage/server_url.dart' as server_url;

Future<String> serverUrl() async {
  return "http://${await server_url.get()}";
}
