import 'package:flutter/material.dart' show Navigator;
import 'package:frontend/screens/alarms/alarms.dart';
import 'utils/ParserAlarm.dart';
import 'package:frontend/Mixins/arrayToString.dart';
import 'package:frontend/utils/parseDays.dart';
import 'utils/format12Hour.dart';
import 'package:frontend/services/api/alarms.dart' as AlarmHttp;

class AlarmsControllers with ArrayToString {
  ParseDays parseDays = ParseDays();
  List? alarms;

  Future<List> getAlarms() async {
    List getAlarms = await AlarmHttp.get();
    return fromJson(getAlarms);
  }

  List fromJson(alarms) {
    ParserAlarm parserAlarm = ParserAlarm();
    return parserAlarm.fromJson(alarms);
  }

  String getTitle(index) {
    int startHour = alarms?[index]["time"]["start_alarm"]["hour"];
    int startMinute = alarms?[index]["time"]["start_alarm"]["minute"];

    int endHour = alarms?[index]["time"]["end_alarm"]["hour"];
    int endMinute = alarms?[index]["time"]["end_alarm"]["minute"];
    return "${Format12Hour(startHour, startMinute)} / ${Format12Hour(endHour, endMinute)}";
  }

  String getDays(index) {
    List alarmDays = alarms?[index]["alarm_days"];
    return arrayToString(parseDays.daysDecode(alarmDays));
  }

  double getMargin(index) {
    return index != (alarms?.length ?? 0) - 1 ? 5 : 80;
  }

  void gotToAddOrEditAlarm(context) {
    Navigator.pushNamed(context, "/addOrEditAlarm");
  }

  List? deleteAlarm(int index) {
    alarms?.removeAt(index);
    return alarms;
  }
}
