import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/constants/serverUrl.dart' as serverData;
import 'package:frontend/services/localStorage/toke.dart';

Future<Map<String, dynamic>> get() async {
  try {
    Uri url = Uri.parse("${serverData.url}/api/alarm/get");
    String? token = await LocalSecureDBToken.get();
    final res = await http.get(url, headers: {"token": token ?? ""});
    final data = await compute(jsonDecode, res.body);
    return {"data": data};
  } on SocketException {
    return {"error": "Habido algún tipo de error por favor intente mas tarde"};
  }
}

Future add(alarm) async {
  Uri url = Uri.parse("${serverData.url}/api/alarm/add");
  String? token = await LocalSecureDBToken.get();
  final res = await http.post(
    url,
    headers: {
      "token": token ?? "",
      'Content-Type': 'application/json',
    },
    body: jsonEncode(alarm),
  );
  final data = jsonDecode(res.body);
  return data;
}

Future delete(id) async {
  Uri url = Uri.parse("${serverData.url}/api/alarm/delete/$id");
  String? token = await LocalSecureDBToken.get();
  final res = await http.delete(
    url,
    headers: {
      "token": token ?? "",
      'Content-Type': 'application/json',
    },
  );
  final data = jsonDecode(res.body);
  return data;
}

Future update(Map alarm, String id) async {
  Uri url = Uri.parse("${serverData.url}/api/alarm/update/$id");
  String? token = await LocalSecureDBToken.get();
  final res = await http.put(
    url,
    headers: {
      "token": token ?? "",
      'Content-Type': 'application/json',
    },
    body: jsonEncode(alarm),
  );
  final data = jsonDecode(res.body);
  return data;
}

Future updateStatus(bool status) async {}
