import 'package:flutter/material.dart' show Navigator;
import 'package:frontend/screens/alarms/alarms.dart';
import 'utils/ParserAlarm.dart';
import 'package:frontend/Mixins/arrayToString.dart';
import 'package:frontend/utils/parseDays.dart';
import 'utils/format12Hour.dart';

class AlarmsControllers with ArrayToString {
  ParseDays parseDays = ParseDays();

  List fromJson({required alarms}) {
    ParserAlarm parserAlarm = ParserAlarm();
    return parserAlarm.fromJson(alarms);
  }

  String getTitle(alarm) {
    int startHour = alarm["time"]["start_alarm"]["hour"];
    int startMinute = alarm["time"]["start_alarm"]["minute"];

    int endHour = alarm["time"]["end_alarm"]["hour"];
    int endMinute = alarm["time"]["end_alarm"]["minute"];
    return "${Format12Hour(startHour, startMinute)} / ${Format12Hour(endHour, endMinute)}";
  }

  String getDays(alarm) {
    List alarmDays = alarm["alarm_days"];
    return arrayToString(parseDays.daysDecode(alarmDays));
  }

  double getMargin(index, alarms) {
    return index != alarms.length - 1 ? 5 : 80;
  }

  void gotToAddOrEditAlarm(context) {
    Navigator.pushNamed(context, "/addOrEditAlarm");
  }

  List deleteAlarm(int index, alarms) {
    alarms.removeAt(index);
    return alarms;
  }
}
