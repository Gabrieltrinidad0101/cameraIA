import 'package:flutter/material.dart';
import 'package:frontend/screens/qrScanner/qrScanner.dart';
import 'package:frontend/screens/home/home.dart';
import 'package:frontend/screens/alarms/alarms.dart';
import 'package:frontend/screens/addOrEditAlarm/addOrEditAlarm.dart';
import 'package:frontend/screens/selectDays/selectDays.dart';
import 'package:frontend/screens/objectToDetect/objectToDetect.dart';

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
        "/addOrEditAlarm": (context) => const AddOrEditAlarm(),
        "/selectDays": (context) => SelectDays(),
        "/objectToDetect": (context) => ObjectToDetect(),
      },
    );
  }
}
