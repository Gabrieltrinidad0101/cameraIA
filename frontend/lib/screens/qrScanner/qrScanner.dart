import 'package:flutter/material.dart';
import 'qrScannerControllers.dart';
import 'package:frontend/screens/home/home.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: QrScannerControllers.has_token(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        if (snapshot.data == true) {
          return const Home();
        }
        return QrScannerPage(context);
      },
    );
  }

  Widget QrScannerPage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/qr_code_app.jpg"),
              ),
              ElevatedButton(
                  onPressed: () {
                    QrScannerControllers.scanQRCode(mounted, context);
                  },
                  child: Text("Scan QR CODE"))
            ],
          ),
        ),
      ),
    );
  }
}
