import 'package:flutter/material.dart';
import 'qrScanner_controllers.dart';
import 'package:frontend/screens/alarms/alarms.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: QrScannerControllers.hasToken(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == true) {
          return const Alarms();
        }
        return qrScannerPage(context);
      },
    );
  }

  Widget qrScannerPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR CODE")),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage("assets/images/qr_code_app.jpg"),
                width: (MediaQuery.maybeOf(context)?.size.width ?? 1) / 3,
              ),
              ElevatedButton(
                  onPressed: () {
                    QrScannerControllers.scanQRCode(mounted, context);
                  },
                  child: const Text("Scan QR CODE"))
            ],
          ),
        ),
      ),
    );
  }
}
