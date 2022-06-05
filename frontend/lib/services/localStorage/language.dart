import 'package:shared_preferences/shared_preferences.dart';

save(String language) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('language', language);
}

Future<String> get() async {
  final prefs = await SharedPreferences.getInstance();
  final String? language = prefs.getString('language');
  return language ?? "es";
}
