import 'package:frontend/constants/socketPathUrl.dart';
import 'package:frontend/services/notification/notificationObjectDetect.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart' show Navigator;

class HomeController {
  IO.Socket? socket;
  HomeController() {
    connectToServerWithSocketIo();
  }
  testStartRunning() {
    listenAlarms();
  }

  connectToServerWithSocketIo() async {
    String url = await getSocketUrl();
    socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders(
                {'Connection': 'upgrade', 'Upgrade': 'websocket'}) // optional
            .build());
    socket?.disconnect();
    socket?.connect();
  }

  listenAlarms() async {
    socket?.on("camera_detect_obejct", (detectObejcts) {
      NotificationObjectDetection().showNotification(detectObejcts);
    });
    socket?.emit("cameras_video", "start");
  }

  go_to_alarms(context) {
    Navigator.of(context).pushNamed("/alarms");
  }
}
