import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/constants/serverUrl.dart' as serverData;
import 'package:frontend/services/localStorage/toke.dart';

Future get() async {
  Uri url = Uri.parse("${serverData.url}/api/alarm/get");
  String? token = await LocalSecureDBToken.get();
  final res = await http.get(url, headers: {"token": token ?? ""});
  final data = await compute(jsonDecode, res.body);
  return data;
}
