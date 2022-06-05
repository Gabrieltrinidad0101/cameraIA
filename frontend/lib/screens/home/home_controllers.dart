import 'package:frontend/constants/socket_path_url.dart';
import 'package:frontend/services/notification/notification_object_detect.dart';
import 'package:frontend/widgets/alert/alert_question.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:frontend/services/localSecureStorage/toke.dart';
import 'package:flutter/material.dart';

class HomeController {
  io.Socket? socket;
  HomeController() {
    connectToServerWithSocketIo();
  }
  testStartRunning() {
    listenAlarms();
  }

  Future<void> deleteSession(BuildContext context) async {
    alertQuestion(
        context: context,
        title: "Eliminar sesión del servidor",
        content: const Text(
            """Estas seguro de eliminar la sesión del servidor no podras ver, agregar modificar y eliminar alarmas"""),
        callBack: () {
          LocalSecureDBToken.delete();
        });
  }

  changeLanguages(BuildContext context) {}

  double setPositionToLogoutButton(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    int paddingTop = 5;
    int buttonLanguage = 50;
    return height - (height / 4) - paddingTop - buttonLanguage;
  }

  connectToServerWithSocketIo() async {
    String url = await getSocketUrl();
    socket = io.io(
        url,
        io.OptionBuilder()
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

  goToAlarms(context) {
    Navigator.of(context).pushNamed("/scannerServer");
  }
}
