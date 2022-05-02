import 'package:flutter/material.dart';
import 'package:frontend/screens/qr_scanner/qr_scanner.dart';
import 'package:frontend/screens/home/home.dart';
import 'package:frontend/screens/Alarms/alarms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const QrScanner(),
        "/home": (context) => const Home(),
        "/alarms": (context) => const Alarms(),
      },
    );
  }
}
