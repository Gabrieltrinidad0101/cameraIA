import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:frontend/widgets/alert/alert.dart';
import 'package:flutter/material.dart' show Navigator, Text;
import 'package:frontend/services/localSecureStorage/toke.dart';

class QrScannerControllers {
  static Future scanQRCode(bool mounted, context) async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "cancel", false, ScanMode.QR);
    if (!mounted)
      // ignore: curly_braces_in_flow_control_structures
      alert(
          context: context,
          title: "Se requiere los permisos de la cámara",
          content: const Text("Aceptar"));
    await LocalSecureDBToken.save(qrCode);
    Navigator.of(context).popAndPushNamed("/alarms");
  }

  static Future<bool> hasToken() async {
    String? token = await LocalSecureDBToken.get();
    return token != null ? true : false;
  }
}
