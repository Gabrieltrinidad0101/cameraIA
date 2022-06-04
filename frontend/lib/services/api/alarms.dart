import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/constants/server_url.dart' as server_data;
import 'package:frontend/services/localStorage/toke.dart';

Future<Map<String, dynamic>> get() async {
  try {
    Uri url = Uri.parse("${server_data.url}/api/alarm/get");
    String? token = await LocalSecureDBToken.get();
    final res = await http.get(url, headers: {"token": token ?? ""});
    final data = await compute(jsonDecode, res.body);
    return {"data": data};
  } on SocketException {
    return {"error": "Habido algún tipo de error por favor intente mas tarde"};
  }
}

Future<Map<String, dynamic>> add(alarm) async {
  try {
    Uri url = Uri.parse("${server_data.url}/api/alarm/add");
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
    return {"id": data["_id"][r"$oid"].toString(), "error": null};
  } on SocketException {
    return {
      "id": null,
      "error": "Habido algún tipo de error por favor intente mas tarde"
    };
  }
}

Future<Map<String, dynamic>> delete(id) async {
  try {
    Uri url = Uri.parse("${server_data.url}/api/alarm/delete/$id");
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
  } on SocketException {
    return {"error": "Habido algún tipo de error por favor intente mas tarde"};
  }
}

Future<Map<String, dynamic>> update(Map alarm, String id) async {
  try {
    Uri url = Uri.parse("${server_data.url}/api/alarm/update/$id");
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
    if (data["error"] != null) {
      return {
        id: null,
        "error": "Habido algún tipo de error por favor intente mas tarde"
      };
    }
    return {"id": id, "error": null};
  } on SocketException {
    return {
      id: null,
      "error": "Habido algún tipo de error por favor intente mas tarde"
    };
  }
}
