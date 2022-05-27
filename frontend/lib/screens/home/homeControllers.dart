import 'package:frontend/constants/socketPathUrl.dart';
import 'package:frontend/services/notification/notificationObjectDetect.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart' show Navigator;
import 'package:broadcastsreceiver/broadcastsreceiver.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print(
        "Native called background task: $task"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

class HomeController {
  Broadcastsreceiver broadcastsreceiver = Broadcastsreceiver();
  HomeController() {
    broadcastsreceiver.runFunctionInBackground(getCamerasVideos);
    NotificationObjectDetection().showNotification();
  }

  callDartMethod() {
    Workmanager().initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode:
            true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );
    Workmanager().registerOneOffTask("task-identifier", "simpleTask");
  }

  getCamerasVideos() async {
    print("   start    ");
    String url = await getSocketUrl();
    IO.Socket socket;
    socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders(
                {'Connection': 'upgrade', 'Upgrade': 'websocket'}) // optional
            .build());
    socket.connect();
    socket.emit("cameras_video", "start");
    socket.on("camera_detect_obejct", (detectObejct) {
      socket.emit("message", detectObejct);
    });
  }

  go_to_alarms(context) {
    Navigator.of(context).pushNamed("/alarms");
  }
}
