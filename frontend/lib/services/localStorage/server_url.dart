import 'package:shared_preferences/shared_preferences.dart';

save(String serverUrl) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('server_url', serverUrl);
}

Future<String?> get() async {
  final prefs = await SharedPreferences.getInstance();
  final String? serverUrl = prefs.getString('server_url');
  return serverUrl;
}
