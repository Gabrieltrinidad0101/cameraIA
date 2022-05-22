import 'package:frontend/constants/socketPathUrl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart' show Navigator;
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

getCamerasVideos() async {
  print("ok");
  String url = await getSocketUrl();
  IO.Socket socket;
  socket = IO.io(
      url,
      IO.OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
          .setExtraHeaders(
              {'Connection': 'upgrade', 'Upgrade': 'websocket'}) // optional
          .build());
  socket.connect();
  socket.emit("cameras_video", "start");
  socket.on("camera_detect_obejct", (detectObejct) {
    socket.emit("message", detectObejct);
  });
}

class HomeController {
  //BackgroundServices backgroundServices = BackgroundServices();
  HomeController() {
    initializeBackgroundServices();
    //backgroundServices.runFunctionInBackground(getCamerasVideos);
  }

  callDartMethod() {
    initializeBackgroundServices();
  }

  initializeBackgroundServices() async {
    await AndroidAlarmManager.initialize();
    final int helloAlarmID = 0;
    await AndroidAlarmManager.periodic(
        const Duration(minutes: 2), helloAlarmID, getCamerasVideos);
  }

  go_to_alarms(context) {
    Navigator.of(context).pushNamed("/alarms");
  }
}
