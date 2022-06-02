import 'package:frontend/constants/socketPathUrl.dart';
import 'package:frontend/services/notification/notificationObjectDetect.dart';
import 'package:frontend/widgets/alert/alertWarning.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart' show BuildContext, MediaQuery, Navigator;
import 'package:frontend/services/localStorage/toke.dart';

class HomeController {
  IO.Socket? socket;
  HomeController() {
    connectToServerWithSocketIo();
  }
  testStartRunning() {
    listenAlarms();
  }

  Future<void> deleteSession(BuildContext context) async {
    alertWarning(
        context: context,
        title: "Eliminar sesión del servidor",
        description:
            """Estas seguro de eliminar la sesión del servidor no podras ver, agregar modificar y eliminar alarmas""",
        callBack: () {
          LocalSecureDBToken.delete();
        });
  }

  double setPositionToLogoutButton(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return height - (height / 4) - 5;
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

  goToAlarms(context) {
    Navigator.of(context).pushNamed("/scannerServer");
  }
}
