import 'package:frontend/constants/socket_path_url.dart';
import 'package:frontend/services/notification/notification_object_detect.dart';
import 'package:frontend/widgets/alert/alert_question.dart';
import 'package:frontend/widgets/text/text_language.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:frontend/services/localSecureStorage/toke.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:frontend/widgets/alert/alert.dart';

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
        title: "logOutTitle",
        content: TextLanguage("logOutMessage"),
        callBack: () {
          LocalSecureDBToken.delete();
        });
  }

  addCamera(bool mounted, context) async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "cancel", false, ScanMode.QR);
    if (!mounted) {
      alert(
          context: context,
          title: "Se requiere los permisos de la cámara",
          content: const Text("Aceptar"));
      return;
    }
    alert(context: context, title: "$qrCode", content: const Text("Aceptar"));
  }

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
