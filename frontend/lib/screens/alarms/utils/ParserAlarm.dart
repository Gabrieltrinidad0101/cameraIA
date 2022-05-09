import 'package:frontend/screens/alarms/alarms.dart';
import 'dart:convert';

import 'package:frontend/utils/parseDays.dart';

class ParserAlarm {
  List fromJson(alarms) {
    ParseDays parseDays = ParseDays();
    List alarmsData = [];
    for (Map data in alarms) {
      Map alarm = json.decode(data["alarm"]);
      alarm["_id"] = data["_id"][r"$oid"];
      alarm["alarm_days"] = parseDays.daysDecode(alarm["alarm_days"]);
      alarmsData.add(alarm);
    }
    return alarmsData;
  }
}
