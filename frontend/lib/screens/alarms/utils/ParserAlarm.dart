import 'package:frontend/screens/alarms/alarms.dart';
import 'dart:convert';

class ParserAlarm {
  List fromJson(alarms) {
    List alarmsData = [];
    for (Map data in alarms) {
      Map alarm = json.decode(data["alarm"]);
      alarmsData.add(alarm);
    }
    return alarmsData;
  }
}
