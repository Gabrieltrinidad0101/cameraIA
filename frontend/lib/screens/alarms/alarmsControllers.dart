import 'package:flutter/material.dart' show Navigator;
import 'package:frontend/widgets/alert/warningDeleteAlarm.dart';
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
    return arrayToString(alarmDays);
  }

  double getMargin(index) {
    return index != (alarms?.length ?? 0) - 1 ? 5 : 80;
  }

  Future<Map> gotToEditAlarm(context, index) async {
    Map data =
        await Navigator.pushNamed(context, "/addOrEditAlarm", arguments: {
      "title": "Edit Alarm",
      "alarm": alarms?[index],
    }) as Map;
    return data;
  }

  Future<Map> gotToAddAlarm(context) async {
    Map newAlarm = await Navigator.pushNamed(context, "/addOrEditAlarm") as Map;
    return newAlarm;
  }

  Future<List?> deleteAlarm(context, int index, Function callBack) async {
    await alertWarning(
        context: context,
        title: "Elimar",
        description: "Deseas eliminar esta alarma",
        callBack: () async {
          await AlarmHttp.delete(alarms?[index]["_id"]);
          alarms?.removeAt(index);
          callBack(alarms);
        });
  }
}
