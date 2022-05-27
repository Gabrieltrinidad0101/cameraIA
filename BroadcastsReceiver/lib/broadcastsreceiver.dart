import 'dart:async';

import 'package:flutter/services.dart';

class Broadcastsreceiver {
  static const MethodChannel _channel = MethodChannel('broadcastsreceiver');

  Future<void> runFunctionInBackground(cb) async {
    _channel.setMethodCallHandler((call) async {
      if (call.method == "run") {
        cb();
      }
    });
  }
  
  Future<void> callDartMethod() async {
    await _channel.invokeMethod('callDartMethod');
  }
}
