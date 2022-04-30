import 'dart:ffi';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:frontend/widgets/alert/info.dart';

class QrScannerControllers {
  static Future scanQRCode(bool mounted, context) async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "cancel", false, ScanMode.QR);
    if (!mounted) alert_info(context: context, title: "", description: "ok");
  }
}
