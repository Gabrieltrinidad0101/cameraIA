import 'dart:async';
import 'dart:ffi';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:frontend/widgets/alert/info.dart';
import 'package:flutter/material.dart' show Navigator, Widget;
import 'package:frontend/services/local_storage/toke.dart';

class QrScannerControllers {
  static Future scanQRCode(bool mounted, context) async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "cancel", false, ScanMode.QR);
    if (!mounted)
      // ignore: curly_braces_in_flow_control_structures
      alert_info(
          context: context,
          title: "Se requiere los permisos de la cámara",
          description: "Aceptar");
    await LocalSecureDBToken.save(qrCode);
    Navigator.of(context).pushNamed("/home");
  }

  static Future<bool> has_token() async {
    String? token = await LocalSecureDBToken.get();
    return token != null ? true : false;
  }
}
