import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/screens/qrScanner/qrScanner.dart';
import 'package:frontend/screens/home/home.dart';
import 'package:frontend/screens/alarms/alarms.dart';
import 'package:frontend/screens/addOrEditAlarm/add_or_edit_alarm.dart';
import 'package:frontend/screens/selectDays/select_days.dart';
import 'package:frontend/screens/objectToDetect/object_to_detect.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/services/localStorage/language.dart'
    as local_db_language;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale("es");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("okkkllllsss");
  }

  @override
  Widget build(BuildContext context) {
    print("okkk");
    return MaterialApp(
      locale: _locale,
      title: 'Camara IA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/home",
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
