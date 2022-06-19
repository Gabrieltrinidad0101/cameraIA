import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:frontend/widgets/alert/alert.dart';
import 'package:flutter/material.dart' show Navigator, Text;
import 'package:frontend/services/localSecureStorage/toke.dart';
import 'package:frontend/services/localStorage/server_url.dart' as server_url;

class QrScannerControllers {
  static Future scanQRCode(bool mounted, context) async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "cancel", false, ScanMode.QR);
    if (!mounted) {
      alert(
          context: context,
          title: "Se requiere los permisos de la cámara",
          content: const Text("Aceptar"));
      return;
    }
    final data = qrCode.split(" ");
    String token = data[0];
    String serverUrl = data[1];
    await server_url.save(serverUrl);
    await LocalSecureDBToken.save(token);
    Navigator.of(context).popAndPushNamed("/alarms");
  }

  static Future<bool> hasToken() async {
    String? token = await LocalSecureDBToken.get();
    return token != null ? true : false;
  }
}
