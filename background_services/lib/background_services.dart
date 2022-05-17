import 'dart:async';
import 'package:flutter/services.dart';

class BackgroundServices {
  static const MethodChannel _channel = MethodChannel('background_services');

  Future<void> runFunctionInBackground(cb) async {
    _channel.setMethodCallHandler((call) async {
      if (call.method == "run") {
        print("ok");
        cb();
      }
    });
  }

  Future<void> callDartMethod() async {
    await _channel.invokeMethod('getPlatformVersion');
  }
}
