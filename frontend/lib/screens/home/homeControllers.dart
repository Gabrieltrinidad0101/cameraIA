// ignore: library_prefixes
import 'package:frontend/constants/socketPathUrl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart' show Navigator;
import 'package:background_services/background_services.dart';

class HomeController {
  HomeController() {
    BackgroundServices backgroundServices = BackgroundServices();
    backgroundServices.runFunctionInBackground(getCamerasVideos);
  }
  getCamerasVideos() async {
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
