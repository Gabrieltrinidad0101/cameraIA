import 'package:flutter/material.dart';
import 'package:frontend/screens/qrScanner/qrScanner.dart';
import 'package:frontend/screens/home/home.dart';
import 'package:frontend/screens/alarms/alarms.dart';
import 'package:frontend/screens/addOrEditAlarm/add_or_edit_alarm.dart';
import 'package:frontend/screens/selectDays/select_days.dart';
import 'package:frontend/screens/objectToDetect/object_to_detect.dart';

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
      initialRoute: "/home",
      routes: {
        "/scannerServer": (context) => const QrScanner(),
        "/home": (context) => const Home(),
        "/alarms": (context) => const Alarms(),
        "/addOrEditAlarm": (context) => const AddOrEditAlarm(),
        "/selectDays": (context) => const SelectDays(),
        "/objectToDetect": (context) => const ObjectToDetect(),
      },
    );
  }
}
