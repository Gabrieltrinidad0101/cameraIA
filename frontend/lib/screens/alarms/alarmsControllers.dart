import 'package:flutter/material.dart' show Navigator;
import 'package:frontend/screens/alarms/alarms.dart';
import 'utils/ParserAlarm.dart';
import 'package:frontend/Mixins/arrayToString.dart';

class AlarmsControllers with ArrayToString {
  List alarms = [];
  AlarmsControllers({required alarms}) {
    ParserAlarm parserAlarm = ParserAlarm();
    this.alarms = parserAlarm.fromJson(alarms);
  }

  String getTitle(int index) {
    int startHour = alarms[index]["time"]["start_alarm"]["hour"];
    int startMinute = alarms[index]["time"]["start_alarm"]["minute"];

    int endHour = alarms[index]["time"]["end_alarm"]["hour"];
    int endMinute = alarms[index]["time"]["end_alarm"]["minute"];
    return "$startHour:$startMinute / $endHour:$endMinute";
  }

  String getDays(int index) {
    List alarmDays = alarms[index]["alarm_days"];
    return arrayToString(alarmDays);
  }

  double getMargin(index) {
    return index != alarms.length - 1 ? 5 : 80;
  }

  void gotToAddOrEditAlarm(context) {
    Navigator.pushNamed(context, "/addOrEditAlarm");
  }
}
